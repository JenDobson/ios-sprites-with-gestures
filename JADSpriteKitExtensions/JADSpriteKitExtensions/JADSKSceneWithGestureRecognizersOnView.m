//
//  JADSKSceneWithScrollingContent.m
//  
//
//  Created by Jennifer Dobson on 2/1/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Jennifer Dobson.
//
//  Permission is hereby granted, free of charge, to any person  obtaining a copy of this software and associated documentation  files(the "Software"), to deal in the Software without   restriction, including without limitation the rights to use,   copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall beincluded in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "JADSKSceneWithGestureRecognizersOnView.h"
#import "JADSKNodeWithGestureRecognizersOnView.h"

@class JADSKNodeWithGestureRecognizersOnView;


@interface JADSKSceneWithGestureRecognizersOnView()

@property (nonatomic, strong) NSArray* p_GestureRecognizers;

@end

@implementation JADSKSceneWithGestureRecognizersOnView

-(void)registerChildNode:(SKNode*) node
{
    if([node isKindOfClass:[JADSKNodeWithGestureRecognizersOnView class]])
    {
        [(JADSKNodeWithGestureRecognizersOnView*)node registerGestureRecognizersWithScene:self];
        
    }

    for (SKNode* child in node.children){
        [self registerChildNode:child];
    }
}

-(void)removeChildrenInArray:(NSArray*)array
{
    [super removeChildrenInArray:array];
    
    for (SKNode* node in array) {
        if ([node isKindOfClass:[JADSKNodeWithGestureRecognizersOnView class]]) {
            [(JADSKNodeWithGestureRecognizersOnView*)node unregisterGestureRecognizersWithScene:self];
        }
    }
}
-(void)removeAllChildren
{
    NSArray* children = self.children;
    [super removeAllChildren];
    for (SKNode* node in children) {
        if ([node isKindOfClass:[JADSKNodeWithGestureRecognizersOnView class]]) {
            [(JADSKNodeWithGestureRecognizersOnView*)node unregisterGestureRecognizersWithScene:self];
        }
    }

}
-(void)addChild:(SKNode *)node
{
    [super addChild:node];
    
    [self registerChildNode:node];
    
    if (self.view) {
        [self turnOffGestureRecognizersOnView:self.view];
        [self turnOnGestureRecognizersOnView:self.view];
    }
    
}


-(void)registerGestureRecognizer:(UIGestureRecognizer *)recognizer
{
    NSMutableArray* gestureRecognizers = [NSMutableArray arrayWithArray:self.p_GestureRecognizers];
    
    if (!gestureRecognizers) {
        gestureRecognizers = [NSMutableArray array];
    }
    
    [gestureRecognizers addObject:recognizer];
    self.p_GestureRecognizers = [NSArray arrayWithArray:gestureRecognizers];
}

-(void)unregisterGestureRecognizer:(UIGestureRecognizer *)recognizer
{
    NSMutableArray* gestureRecognizers = [NSMutableArray arrayWithArray:self.p_GestureRecognizers];
    
    [gestureRecognizers removeObject:recognizer];
    self.p_GestureRecognizers = [NSArray arrayWithArray:gestureRecognizers];
}

-(void)willMoveFromView:(SKView *)view
{
    [super willMoveFromView:view];
    
    [self turnOffGestureRecognizersOnView:view];
}

-(void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    [self turnOnGestureRecognizersOnView:view];

}

-(void)turnOnGestureRecognizersOnView:(SKView*)view
{
    for (UIGestureRecognizer* recognizer in self.p_GestureRecognizers)
    {
        [view addGestureRecognizer:recognizer];
    }
}
-(void)turnOffGestureRecognizersOnView:(SKView*)view
{
    for (UIGestureRecognizer* recognizer in [view gestureRecognizers]) {
        [view removeGestureRecognizer:recognizer];
    }
    
}
@end
