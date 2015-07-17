//
//  JADSKScrollingNode.h
//  FirstLetters
//
//  Created by Jennifer Dobson on 2/1/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Jennifer Dobson.
//
//  Permission is hereby granted, free of charge, to any person  obtaining a copy of this software and associated documentation  files(the "Software"), to deal in the Software without   restriction, including without limitation the rights to use,   copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall beincluded in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import <SpriteKit/SpriteKit.h>
#import "JADSKNodeWithGestureRecognizersOnView.h"

@interface JADSKScrollingNode : JADSKNodeWithGestureRecognizersOnView <UIGestureRecognizerDelegate>


//@property (nonatomic) CGSize size;
@property (nonatomic, strong) SKSpriteNode* scrollingContent;


@property (nonatomic) BOOL allowsHorizontalScroll;
@property (nonatomic) BOOL allowsVerticalScroll;
@property (nonatomic) BOOL allowsRotation;
@property (nonatomic) BOOL allowsPinch;

//-(id)initWithSize:(CGSize)size;

-(void)scrollToTop;
-(void)scrollToBottom;
-(void)scrollToLeft;
-(void)scrollToRight;
-(void)scrollToMiddle;

-(CGFloat)zoomFactorWidth;
-(CGFloat)zoomFactorHeight;


-(void)resetScrollingContent;

@property (nonatomic) CGFloat maxScale;
@property (nonatomic) CGFloat minScale;

@end
