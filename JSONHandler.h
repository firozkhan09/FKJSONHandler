//
//  JSONHandler.h
//  TrebleFish
//
//  Created by LaxMac on 28/01/16.
//  Copyright © 2016 LaxMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^completion)(NSError *error,NSDictionary *responseDict,NSData *contentData);

@interface JSONHandler : NSObject

+(id)sharedHandler;

-(void)getResponseWithURL:(NSURL *)respURL WithControllerView:(UIView *)view AndBlock:(completion)respBlock;

-(void)getResponseWithURL:(NSURL *)respURL AndBlock:(completion)respBlock;

@property(strong,nonatomic)UIActivityIndicatorView *spinner;

@end
