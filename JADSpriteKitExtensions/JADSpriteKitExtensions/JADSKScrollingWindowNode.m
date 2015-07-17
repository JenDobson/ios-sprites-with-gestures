//
//  JADSKScrollingWindowNode.m
//  JADSpriteKitExtensions
//
//  Created by Jennifer Dobson on 2/1/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Jennifer Dobson.
//
//  Permission is hereby granted, free of charge, to any person  obtaining a copy of this software and associated documentation  files(the "Software"), to deal in the Software without   restriction, including without limitation the rights to use,   copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall beincluded in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



#define DEBUG_IMAGE_COORDS 0

#import "JADSKScrollingWindowNode.h"
#import "JADSKScrollingNode.h"

// FOR DEBUGGING CONTENT COORDS --> IMAGE COORDS
#if DEBUG_IMAGE_COORDS
#import "JDWOLHelpers.h"
#endif




@interface JADSKScrollingWindowNode()

@property (nonatomic, strong) SKCropNode* cropNode;
@property (nonatomic, strong) JADSKScrollingNode* scrollingNode;
@property (nonatomic, strong) SKSpriteNode* contentNode;


@end

@implementation JADSKScrollingWindowNode

// ScrollingNode interface
-(void)setScrollingContent:(SKSpriteNode *)scrollingContent
{
    _scrollingNode.scrollingContent = scrollingContent;
}
-(SKSpriteNode*)scrollingContent
{
    return self.scrollingNode.scrollingContent;
}
-(void)setAllowsHorizontalScroll:(BOOL)hs
{
    _scrollingNode.allowsHorizontalScroll = hs;
}
-(BOOL)allowsHorizontalScroll
{
    return self.scrollingNode.allowsHorizontalScroll;
}
-(void)setAllowsVerticalScroll:(BOOL)vs
{
    _scrollingNode.allowsVerticalScroll = vs;
}
-(BOOL)allowsVerticalScroll
{
    return self.scrollingNode.allowsVerticalScroll;
}
-(void)setAllowsRotation:(BOOL)ar
{
    _scrollingNode.allowsRotation = ar;
}
-(BOOL)allowsRotation
{
    return self.scrollingNode.allowsRotation;
}
-(void)setAllowsPinch:(BOOL)p
{
    _scrollingNode.allowsPinch = p;
}
-(BOOL)allowsPinch
{
    return self.scrollingNode.allowsPinch;
}


-(void)scrollToTop
{
    [self.scrollingNode scrollToTop];
}
-(void)scrollToBottom
{
    [self.scrollingNode scrollToBottom];
}
-(void)scrollToLeft
{
    [self.scrollingNode scrollToLeft];
}
-(void)scrollToRight
{
    [self.scrollingNode scrollToRight];
}
-(void)scrollToMiddle;
{
    [self.scrollingNode scrollToMiddle];
}
-(CGFloat)zoomFactorWidth
{
    return [self.scrollingNode zoomFactorWidth];
}
-(CGFloat)zoomFactorHeight
{
    return [self.scrollingNode zoomFactorHeight];
}

-(void)resetScrollingContent
{
    [self.scrollingNode resetScrollingContent];
}
-(void)setMaxScale:(CGFloat)maxScale
{
    _scrollingNode.maxScale = maxScale;
}
-(CGFloat)maxScale
{
    return self.scrollingNode.maxScale;
}
-(void)setMinScale:(CGFloat)minScale
{
    _scrollingNode.minScale = minScale;
}
-(CGFloat)minScale
{
    return self.scrollingNode.minScale;
}

-(void)setContentNode:(SKSpriteNode *)contentNode
{
    _scrollingNode.scrollingContent = contentNode;
    
}

-(SKSpriteNode*)contentNode{
    return _scrollingNode.scrollingContent;
}



//////////////////////////////////
/////////  ScrollingWindow Methods
//////////////////////////////////
-(id)initWithSize:(CGSize)size
{
    self = [super init];
    
    if (self)
    {
        SKSpriteNode *backgroundNode = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:size];
        SKSpriteNode *maskNode = [backgroundNode copy];
        
        _cropNode = [SKCropNode node];
        _cropNode.maskNode = maskNode;
        [_cropNode addChild:backgroundNode];
        [self addChild:_cropNode];
        
        _scrollingNode = [[JADSKScrollingNode alloc] init];
        
        [backgroundNode addChild:_scrollingNode];
        
    }
    
    return self;
    
}




//-(BOOL)containsPoint:(CGPoint)p
//{
//    return [self.cropNode.maskNode containsPoint:p];
//}
//-(CGRect)frame
//{
//    CGSize frameSize = self.cropNode.maskNode.frame.size;
//    CGPoint frameOrigin = (CGPoint){self.position.x - frameSize.width/2, self.position.y - frameSize.height/2};
//    return CGRectMake(frameOrigin.x, frameOrigin.y, frameSize.width, frameSize.height);
//}


//
//-(CGPoint)convertPoint:(CGPoint)point toNode:(SKNode *)node
//{
//    return [self.cropNode.maskNode convertPoint:point toNode:node];
//}

-(CGRect)calculateAccumulatedFrame
{
    return self.cropNode.maskNode.frame;
}



@end
