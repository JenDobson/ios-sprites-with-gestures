//
//  ViewController.m
//  JADSKSpriteKitExtensionsDevApp
//
//  Created by Jennifer Dobson on 7/12/15.
//  Copyright (c) 2015 Jennifer Dobson. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>

#import "MyScene.h"



@interface ViewController ()

@property (nonatomic, strong) MyScene* myScene;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SKView* skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    CGSize sceneSize = CGSizeMake(skView.bounds.size.width,skView.bounds.size.height);
    
    _myScene = [[MyScene alloc] initWithSize:sceneSize];
    
    [(SKView*)self.view presentScene:_myScene];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView
{
    CGRect viewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    SKView* view = [[SKView alloc] initWithFrame:viewFrame];
    self.view = view;
}


#pragma mark - Device Orientation

- (BOOL)shouldAutorotate
{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskLandscape;
    }
}
@end
