//
//  GameViewController.m
//  HelloArrow
//
//  Created by Sid on 12/02/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

#import "GameViewController.h"
#import "AppEngine.h"

@implementation GameViewController
{
    AppEngine *_engine;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _engine = [AppEngine engineWithView:(MTKView *)self.view];
}

@end

