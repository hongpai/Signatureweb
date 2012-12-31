//
//  WebRemote.m
//  Signature
//
//  Created by pai hong on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebRemote.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"
#import "SigViewController.h"


#import "InforTools.h"

@implementation WebRemote

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

NSString *serverIPname;

-(void)setServerIPname:(NSString *)name{
    serverIPname = [NSString stringWithFormat:@"%@",name];
}

#pragma mark ---是否通畅---
-(BOOL)isServerValiding{
    //NSString *path = [NSString stringWithFormat:@"http://%@/SaveImages.aspx",serverIPname];
    NSString *path = [NSString stringWithFormat:@"http://%@",serverIPname];
    Reachability *hostvalid = [Reachability reachabilityWithHostName:path];
    NetworkStatus status = [hostvalid currentReachabilityStatus];
    return !(status==NotReachable);
}

#pragma mark --- 得到数据 ---
-(void)postUIImageToServer:(UIImage *)image{
    
    postdata = [[NSData alloc] initWithData:(UIImagePNGRepresentation(image))];
    
    //http://192.168.0.142/SaveImages.aspx
    //NSURL *url = [NSURL URLWithString:@"http://www.samengine.com/KeDingWeb/GetBookInfo.aspx"];
    
    NSString *path = [NSString stringWithFormat:@"http://%@/SaveImages.aspx",serverIPname];
    
    NSURL *url = [NSURL URLWithString:path];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.tag = 0;
    
    //multipart/form-data
    //[request setValidatesSecureCertificate:NO];
    //[request setPostFormat:ASIMultipartFormDataPostFormat];
    //[request setRequestMethod:@"POST"];
	//[request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    //[request setPostValue:postdata forKey:@"imagedata"];
    [request addData:postdata withFileName:@"qweqwewe.png" andContentType:@"image/png" forKey:@"photos"];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSLog(@" %d  %@",request.responseStatusCode,responseString);
    
    //[InforTools alert:responseString];
    
    if (request.tag==0 && request.responseStatusCode == 200) {//跟踪信息
        NSLog(@" %d  %@",request.responseStatusCode,responseString);
        [((SigViewController *)delegate) showResultTipInfor:@"" :YES];
    }else {
        NSLog(@"request。tag   none");
    }
    
    [self disponse];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{    
    NSLog(@"%@",request.error);

    if (request.tag ==0 ) {
    }
    NSLog(@"传递失败1");
    [((SigViewController *)delegate) showResultTipInfor:[request.error description] :NO];
    //NSError *error = [request error];
    
    [self disponse];
}

-(void)disponse{
    delegate = nil;
    [postdata release];
    [self release];
}
















@end
