//
//  JSONHandler.m
//  TrebleFish
//
//  Created by LaxMac on 28/01/16.
//  Copyright © 2016 LaxMac. All rights reserved.
//

#import "JSONHandler.h"

@implementation JSONHandler

+(id)sharedHandler{
    
    static JSONHandler *responseHandler=nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        responseHandler=[[self alloc] init];
    });
    
    return responseHandler;
}

-(void)getResponseWithURL:(NSURL *)respURL WithControllerView:(UIView *)view AndBlock:(completion)respBlock{
    
    UIView *blurView=[[UIView alloc] init];
    blurView.backgroundColor=[UIColor colorWithWhite:.1 alpha:.2];
    blurView.frame=view.bounds;
    [view addSubview:blurView];
    
    _spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2)-50,([UIScreen mainScreen].bounds.size.height/2)-50,100,100)];
    
    _spinner.color = [UIColor whiteColor];
    [_spinner startAnimating];
    [blurView addSubview:_spinner];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:respURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [_spinner stopAnimating];
        [_spinner removeFromSuperview];
        _spinner=nil;
        [blurView removeFromSuperview];
        
        if (data) {
          NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
          respBlock(connectionError,responseDict,data);
        }
        else{
        respBlock(connectionError,nil,data);
        }
    }];
}

-(void)getResponseWithURL:(NSURL *)respURL AndBlock:(completion)respBlock{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:respURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *responseDict;
        
        if (data) {
            responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            respBlock(connectionError,responseDict,data);
        }
        else{
            respBlock(connectionError,responseDict,data);
        }
    }];
}

@end
