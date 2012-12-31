//
//  DrawLinerLayer.h
//  MagazineIpad
//
//  Created by pai hong on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLinerLayer : UIView{
    NSMutableArray *lines;
}

-(void)diponse;
-(void)reset;
-(UIImage *)getImageRendering;
//-(UIImage *)imageByRenderingview;

@end
