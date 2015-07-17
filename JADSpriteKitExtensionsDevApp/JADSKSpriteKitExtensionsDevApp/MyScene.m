//
//  MyScene.m
//  JADSKSpriteKitExtensionsDevApp
//
//  Created by Jennifer Dobson on 7/12/15.
//  Copyright (c) 2015 Jennifer Dobson. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()

@property (nonatomic, strong) JADSKScrollingWindowNode* verticalScrollingNode;
@property (nonatomic, strong) JADSKScrollingWindowNode* horizontalScrollingNode;
@end

@implementation MyScene


-(void)didMoveToView:(SKView*)view
{
    [super didMoveToView:view];
    
    // Set up some parameters
    NSArray *colorsArray = @[[SKColor blueColor],[SKColor greenColor],[SKColor redColor],[SKColor whiteColor]];
    CGFloat squareSideLength = 100;
    CGFloat squareSpacing = 20;

    
    ///////////////////////////////////
    // Make a horizontal scrolling node
    ///////////////////////////////////
    
    // First draw the content
    SKSpriteNode* fourHorizontalSquaresNode = [[SKSpriteNode alloc] init];
    
    CGFloat horizontalPosition = 0;
    for (int i=0; i<4; i++){
        SKSpriteNode* squareNodeToAdd = [[SKSpriteNode alloc] initWithColor:[colorsArray objectAtIndex:i] size:(CGSize){squareSideLength,squareSideLength}];
        squareNodeToAdd.position = CGPointMake(horizontalPosition, 0);
        horizontalPosition = horizontalPosition + squareSideLength + squareSpacing;
        [fourHorizontalSquaresNode addChild:squareNodeToAdd];
        
    }
    
    // Then add the content to a scrolling node
    self.horizontalScrollingNode = [[JADSKScrollingWindowNode alloc] initWithSize:(CGSize){2*squareSideLength,squareSideLength+2*squareSpacing}];
    self.horizontalScrollingNode.position = CGPointMake([UIScreen mainScreen].bounds.size.width*.25, [UIScreen mainScreen].bounds.size.height*.5);

    self.horizontalScrollingNode.scrollingContent = fourHorizontalSquaresNode;
    
    CGRect theframe = [fourHorizontalSquaresNode calculateAccumulatedFrame];
    NSLog(@"theframe:%f,%f,%f,%f,",theframe.origin.x,theframe.origin.y,theframe.size.width,theframe.size.height);
   
    self.horizontalScrollingNode.allowsHorizontalScroll = YES;
    self.horizontalScrollingNode.allowsVerticalScroll = NO;
    self.horizontalScrollingNode.allowsPinch = NO;
    self.horizontalScrollingNode.allowsRotation = NO;
    
    [self addChild:self.horizontalScrollingNode];
    [self.horizontalScrollingNode scrollToLeft];
    
    ///////////////////////////////////
    // Make a vertical scrolling node
    ///////////////////////////////////
    
    // First draw the content
    SKSpriteNode* fourVerticalSquaresNode = [[SKSpriteNode alloc] init];
    
    CGFloat verticalPosition = 0;
    for (int i=0; i<4; i++){
        SKSpriteNode* squareNodeToAdd = [[SKSpriteNode alloc] initWithColor:[colorsArray objectAtIndex:i] size:(CGSize){squareSideLength,squareSideLength}];
        squareNodeToAdd.position = CGPointMake(0,verticalPosition);
        verticalPosition = verticalPosition + squareSideLength + squareSpacing;
        [fourVerticalSquaresNode addChild:squareNodeToAdd];
    }
    
    // Then add the content to a scrolling node
    self.verticalScrollingNode = [[JADSKScrollingWindowNode alloc] initWithSize:(CGSize){squareSideLength+2*squareSpacing,2*squareSideLength,}];
    self.verticalScrollingNode.position = CGPointMake([UIScreen mainScreen].bounds.size.width*.75, [UIScreen mainScreen].bounds.size.height*.5);
    self.verticalScrollingNode.scrollingContent = fourVerticalSquaresNode;
    self.verticalScrollingNode.allowsHorizontalScroll = NO;
    self.verticalScrollingNode.allowsVerticalScroll = YES;
    self.verticalScrollingNode.allowsPinch = NO;
    self.verticalScrollingNode.allowsRotation = NO;
    
    [self addChild:self.verticalScrollingNode];
    [self.verticalScrollingNode scrollToTop];

}
@end
