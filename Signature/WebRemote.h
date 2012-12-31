//
//  WebRemote.h
//  Signature
//
//  Created by pai hong on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebRemote : NSObject{
    NSData *postdata;
    id delegate;
}

@property(nonatomic,assign)id delegate;

-(void)setServerIPname:(NSString *)name;

-(void)postUIImageToServer:(UIImage *)image;
-(BOOL)isServerValiding;
@end
