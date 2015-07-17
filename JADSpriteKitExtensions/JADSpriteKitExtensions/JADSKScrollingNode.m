//
//  JADSKScrollingNode.m
//  JADSKSpriteKitExtensions
//
//  Created by Jennifer Dobson on 2/1/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Jennifer Dobson.
//
//  Permission is hereby granted, free of charge, to any person  obtaining a copy of this software and associated documentation  files(the "Software"), to deal in the Software without   restriction, including without limitation the rights to use,   copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall beincluded in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



#import "JADSKScrollingNode.h"
#import "JADSKSceneWithGestureRecognizersOnView.h"


@interface JADSKScrollingNode()

@property (nonatomic) CGFloat minYPosition;
@property (nonatomic) CGFloat maxYPosition;
@property (nonatomic) CGFloat minXPosition;
@property (nonatomic) CGFloat maxXPosition;
@property (nonatomic) CGFloat originalWidth;
@property (nonatomic) CGFloat originalHeight;


@property (nonatomic, strong) UIPanGestureRecognizer *p_panGestureRecognizer;
@property (nonatomic, strong) UIPinchGestureRecognizer *p_pinchGestureRecognizer;
@property (nonatomic, strong) UIRotationGestureRecognizer *p_rotationGestureRecognizer;

@end


static const CGFloat kScrollDuration = .3;

@implementation JADSKScrollingNode

-(void)resetScrollingContent
{
    self.scrollingContent.size = (CGSize){self.originalWidth,self.originalWidth};
    //self.scrollingContent.anchorPoint = (CGPoint){.5,.5};
    
    //self.scrollingContent.anchorPoint = (CGPoint){scrollingContentFrame.origin.x,.5};
    self.scrollingContent.position = (CGPoint){0,0};
    
    
}
-(void)doRegisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView *)scene
{
    [scene registerGestureRecognizer:self.p_panGestureRecognizer];
    [scene registerGestureRecognizer:self.p_pinchGestureRecognizer];
    [scene registerGestureRecognizer:self.p_rotationGestureRecognizer];
}
-(void)doUnregisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView *)scene
{
    [scene unregisterGestureRecognizer:self.p_panGestureRecognizer];
    [scene unregisterGestureRecognizer:self.p_pinchGestureRecognizer];
    [scene unregisterGestureRecognizer:self.p_rotationGestureRecognizer];
}

-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ScrollingNode Position Changed" object:self]];
    
    NSLog(@"position:%f,%f",position.x,position.y);
    
    
}
//-(id)initWithSize:(CGSize)size
-(id)init
{
    self = [super init];
    
    if (self)
    {
        //_size = size;
        
        _minScale = .1;
        _maxScale = 5;
        
        _p_panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        _p_panGestureRecognizer.delegate = self;
        
        
        _p_pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinchFrom:)];
        _p_pinchGestureRecognizer.delegate = self;
        
        
        _p_rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
        _p_rotationGestureRecognizer.delegate = self;
        
        _allowsHorizontalScroll = YES;
        _allowsVerticalScroll = YES;
        _allowsPinch = YES;
        _allowsRotation = YES;
        
    }
    return self;
    
}



-(void)setScrollingContent:(SKSpriteNode*)scrollingContent
{
    
    @try {
        if (_scrollingContent) {
            [self removeChildrenInArray:@[_scrollingContent]];
        }
        
        _scrollingContent = scrollingContent;
        
        [self addChild:_scrollingContent];
        
        _originalHeight = _scrollingContent.size.height;
        _originalWidth = _scrollingContent.size.width;
        //_originalHeight = [_scrollingContent calculateAccumulatedFrame].size.height;
        //_originalWidth = [_scrollingContent calculateAccumulatedFrame].size.width;
        
        [self resetScrollingContent];
        
        NSLog(@"sc x:%f,y:%f,width:%f,height:%f",_scrollingContent.position.x,_scrollingContent.position.y,_scrollingContent.size.width,_scrollingContent.size
              .height);

    }
    @catch (NSException *exception) {
        if ([exception.reason hasPrefix:@"Attemped to add a SKNode which already has a parent:"]) {
            [NSException exceptionWithName:@"JADSpriteKitExtensionsInvalidArgumentException" reason:@"Attempted to set scrolling content with SKNode that already has a parent" userInfo:nil];
        }
        else
            [exception raise];
    }
    @finally {
    }
    
}

-(CGFloat)zoomFactorHeight
{
    return self.scrollingContent.frame.size.height/self.originalHeight;
}
-(CGFloat)zoomFactorWidth
{
    return self.scrollingContent.frame.size.width/self.originalWidth;
}
-(CGFloat) minYPosition
{
    CGSize parentSize = self.parent.frame.size;
    
    CGRect scrollingContentFrame = [self.scrollingContent calculateAccumulatedFrame];
    
    return .5*parentSize.height-(scrollingContentFrame.origin.y+scrollingContentFrame.size.height);
}

-(CGFloat) maxYPosition
{

    
    CGSize parentSize = self.parent.frame.size;
    
    CGRect scrollingContentFrame = [self.scrollingContent calculateAccumulatedFrame];
    NSLog(@"scrolling content frame:%f,%f,%f,%f",scrollingContentFrame.origin.x,scrollingContentFrame.origin.y,scrollingContentFrame.size.width,scrollingContentFrame.size.height);
    return -.5*parentSize.height - scrollingContentFrame.origin.y;
}

-(CGFloat) maxXPosition
{
    CGSize parentSize = self.parent.frame.size;
    
    CGRect scrollingContentFrame = [self.scrollingContent calculateAccumulatedFrame];
    
    NSLog(@"scrolling content frame:%f,%f,%f,%f",scrollingContentFrame.origin.x,scrollingContentFrame.origin.y,scrollingContentFrame.size.width,scrollingContentFrame.size.height);
    return -.5*parentSize.width - scrollingContentFrame.origin.x;

}

-(CGFloat) minXPosition
{
    CGSize parentSize = self.parent.frame.size;
    
    
    CGRect scrollingContentFrame = [self.scrollingContent calculateAccumulatedFrame];
    
    return .5*parentSize.width-(scrollingContentFrame.origin.x+scrollingContentFrame.size.width);

}
-(void)scrollToBottom
{
    self.position = CGPointMake(0, self.maxYPosition);
}

-(void)scrollToTop
{
    self.position = CGPointMake(0, self.minYPosition);
}
-(void)scrollToLeft
{
    self.position = CGPointMake(self.maxXPosition,0);
}
-(void)scrollToRight
{
    self.position = CGPointMake(self.minXPosition,0);
}
-(void)scrollToMiddle
{
    self.position = CGPointMake((self.maxXPosition-self.minXPosition)/2,(self.maxYPosition-self.minYPosition)/2);
}
-(void)handleRotationFrom:(UIRotationGestureRecognizer*)recognizer
{
    
    if (!self.allowsRotation) {
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self rotateContentQuarterTurnClockwise:(recognizer.rotation>0)];
        recognizer.rotation = 0;
    }
    
}

-(void)rotateContentQuarterTurnClockwise:(BOOL)clockwise
{
    if (clockwise) {
        [self.scrollingContent runAction:[SKAction rotateByAngle:-M_PI/2 duration:0]];
    }
    else {
        [self.scrollingContent runAction:[SKAction rotateByAngle:M_PI/2 duration:0]];
    }
    
    
    CGFloat originalWidthTemp = self.originalWidth;
    self.originalWidth = self.originalHeight;
    self.originalHeight = originalWidthTemp;
    
}
-(void)handlePinchFrom:(UIPinchGestureRecognizer*)recognizer
{

    if (!self.allowsPinch) {
        return;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
    
    CGSize newSize = CGRectApplyAffineTransform(self.scrollingContent.frame, transform).size;
    
    if (newSize.width > self.originalWidth*self.maxScale) {
        newSize.width = self.originalWidth*self.maxScale;
        newSize.height = self.originalHeight*self.maxScale;
    }
    if (newSize.width < self.originalWidth*self.minScale) {
        newSize.width = self.originalWidth*self.minScale;
        newSize.height = self.originalWidth*self.minScale;
    }
    
    self.scrollingContent.size = newSize;

    recognizer.scale = 1;
    
}


-(void)handlePanFrom:(UIPanGestureRecognizer*)recognizer
{
    
    if (!(self.allowsHorizontalScroll || self.allowsVerticalScroll)) {
        return;
    }
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        CGPoint pos = self.position;
        CGPoint p = mult(velocity, kScrollDuration);
        
        CGPoint newPos = CGPointMake(pos.x + p.x, pos.y - p.y);
        newPos = [self constrainStencilNodesContainerPosition:newPos];
        
        SKAction *moveTo = [SKAction moveTo:newPos duration:kScrollDuration];
        [moveTo setTimingMode:SKActionTimingEaseOut];
        [self runAction:moveTo];
        
    }
    
}



-(void)panForTranslation:(CGPoint)translation
{
    if (!self.allowsVerticalScroll) {
        translation.y = 0;
    }
    if (!self.allowsHorizontalScroll){
        translation.x = 0;
    }
    
    self.position = CGPointMake(self.position.x+translation.x, self.position.y+translation.y);
}

- (CGPoint)constrainStencilNodesContainerPosition:(CGPoint)position {
    
    CGPoint retval = position;
    
    if (self.allowsHorizontalScroll){
        retval.x = MAX(retval.x, self.minXPosition);
        retval.x = MIN(retval.x, self.maxXPosition);
    }
    else{
        retval.x = self.position.x;
    }
    if (self.allowsVerticalScroll) {
        retval.y = MAX(retval.y, self.minYPosition);
        retval.y = MIN(retval.y, self.maxYPosition);        
    }
    else{
        retval.y = self.position.y;
    }

    return retval;
}


CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    SKNode* grandParent = self.parent.parent;
    
    if (!grandParent) {
        grandParent = self.parent;
    }
    CGPoint touchLocation = [touch locationInNode:grandParent];
    
    if (!CGRectContainsPoint(self.parent.frame,touchLocation)){
        
        return NO;
    }
        
    return YES;
}

@end
