//
//  JADSKNodeWithGestureRecognizersOnView.m
//  JDWorldOfLetters
//
//  Created by Jennifer Dobson on 2/1/15.
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Jennifer Dobson.
//
//  Permission is hereby granted, free of charge, to any person  obtaining a copy of this software and associated documentation  files(the "Software"), to deal in the Software without   restriction, including without limitation the rights to use,   copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall beincluded in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "JADSKNodeWithGestureRecognizersOnView.h"
#import "JADSKSceneWithGestureRecognizersOnView.h"

@implementation JADSKNodeWithGestureRecognizersOnView

-(void)registerGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView *)scene
{
    [self doRegisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView*)scene];
    
}

-(void)unregisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView *)scene
{
    [self doUnregisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView*)scene];
    
}
-(void)doRegisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView*)scene
{
    [NSException raise:@"Method Not Implemented" format:@"Must implement method ""doRegisterGestureRecognizersWithScene"" in JADSKNodeWithGestureRecognizersOnView subclass %@", [self class]];
    
}

-(void)doUnregisterGestureRecognizersWithScene:(JADSKSceneWithGestureRecognizersOnView*)scene
{
    [NSException raise:@"Method Not Implemented" format:@"Must implement method ""doUnregisterGestureRecognizersWithScene"" in JADSKNodeWithGestureRecognizersOnView subclass %@", [self class]];
    
}

-(void)removeFromParent
{
    JADSKSceneWithGestureRecognizersOnView* scene = (JADSKSceneWithGestureRecognizersOnView*)self.scene;
    
    [super removeFromParent];
    
    [self unregisterGestureRecognizersWithScene:scene];
}

@end
