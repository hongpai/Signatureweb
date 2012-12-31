//
//  SigViewController.h
//  Signature
//
//  Created by pai hong on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawLinerLayer;

@interface SigViewController : UIViewController{
    DrawLinerLayer *drawlayer;
    
    IBOutlet UIView *cankaoview;
    
    IBOutlet UIView *urlView;
    IBOutlet UITextField *txtField;
    
    IBOutlet UILabel *resultInfor;
    
    IBOutlet UIImageView *cloudImage;
    
}
@property(nonatomic,retain)UIImageView *cloudImage;

@property(nonatomic,retain)UILabel *resultInfor;

@property(nonatomic,retain)UIView *cankaoview;
@property(nonatomic,retain)UITextField *txtField;
@property(nonatomic,retain)UIView *urlView;

-(IBAction)showResultTipInfor:(NSString *)str :(BOOL)issuccess;

@end
