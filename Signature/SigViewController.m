//
//  SigViewController.m
//  Signature
//
//  Created by pai hong on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SigViewController.h"
#import "FileTools.h"
#import "WebRemote.h"
#import "DrawLinerLayer.h"
#import "InforTools.h"
#import <QuartzCore/QuartzCore.h>

@interface SigViewController ()

@end

@implementation SigViewController

@synthesize cankaoview,txtField,urlView,resultInfor,cloudImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //NSString *bgpath = [FileTools getFilePathInAppBundle_filename:@"bg_app" ext:@"jpg"];
    
    //UIImageView *bgview = [[UIImageView alloc] initWithImage: ([UIImage imageWithContentsOfFile:bgpath])];
    //[self.view addSubview:bgview];
    
    //创建画布
    [self createDrawLayer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

#pragma mark ---创建画布---
-(void)createDrawLayer{
    drawlayer = [[DrawLinerLayer alloc] initWithFrame:cankaoview.frame];
    [self.view addSubview:drawlayer];
    [drawlayer release];
}


#pragma mark ---点击了发送按钮----
-(IBAction)clickSenderBtn:(id)sender{
    UIImage *resultimg = [drawlayer getImageRendering];
    
    WebRemote *webremote = [[WebRemote alloc] init];
    webremote.delegate  = self;
    [webremote setServerIPname:txtField.text];
    
    if ([webremote isServerValiding]) {
        
        [webremote postUIImageToServer:resultimg];
        
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 2;
        [animation setRepeatCount:3];
        [animation setRepeatDuration:2];
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"rippleEffect";//水纹  翻转cube
        
        
        //[self addSubview:targetView];
        [[cloudImage layer] addAnimation:animation forKey:@"animation"];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(moveover)];
        drawlayer.alpha = 0;
        [UIView commitAnimations];
        

        //[drawlayer reset];
    }else {
        [InforTools alert:@"网络不通畅!"];
        return;
    }
}

-(void)moveover{
    [drawlayer reset];
    drawlayer.alpha = 1;
}

#pragma mark ---清除按钮----
-(IBAction)clickclearBtn:(id)sender{
    [drawlayer reset];
}

#pragma mark ---点击了更改url的按钮---
-(IBAction)clickChangedURL:(id)sender{
    [self.view addSubview:urlView];
}

-(IBAction)clickChangedOVER:(id)sender{
    [urlView removeFromSuperview];
}


#pragma mark ---显示提示框---
-(IBAction)showResultTipInfor:(NSString *)str :(BOOL)issuccess{
    if (issuccess) {
        resultInfor.text = @"传输成功";
    }else {
        resultInfor.text = [NSString stringWithFormat:@"失败%@",str];        
    }
    
    [self performSelector:@selector(clearInfor) withObject:nil afterDelay:1.5f];
}

-(void)clearInfor{
    resultInfor.text = @"";
}





















@end
