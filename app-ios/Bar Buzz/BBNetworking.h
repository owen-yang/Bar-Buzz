//
//  BBNetworking.h
//  Bar Buzz
//
//  Created by Owen Yang on 5/16/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BBRequestType) {
    BBRequestTypePOST,
    BBRequestTypeGET,
    BBRequestTypePUT,
    BBRequestTypeDELETE
};

typedef NS_ENUM(NSInteger, BBRequestRoute) {
    BBRequestRouteAPIBars,          /*  /api/bars/          */
    BBRequestRouteAPIBarsLocate     /*  /api/bars/locate/   */
};

typedef NS_ENUM(NSInteger, BBContentType) {
    BBContentTypeJSON,              /*  application/json    */
};

@interface BBNetworking : NSObject

/*!
 Sends an asynchronous NSURLRequest of the specified BBRequestType to the specified API route/append with parameters. Body should be a JSON object. The response parameters are forwarded by calling block.
 
 @param         type        The type of request
 @param         route       The route to send the request to
 @param         append      A string to append to the route
 @param         parameters  Any parameters to the request (separated by '&')
 @param         body        The body of the request in JSON dictionary format
 @param         block       Block to forward response to
 */
+ (void)sendAsynchronousRequestType:(BBRequestType)requestType
                            toRoute:(BBRequestRoute)route
                          appending:(NSString*)append
                         parameters:(NSArray*)parameters
                       withJSONBody:(NSDictionary*)body
                              block:(void (^)(NSURLResponse *response, NSData *data, NSError *error))block;

/*!
 Sends an asynchronous NSURLRequest of the specified BBRequestType to the specified API route/append with parameters. The response parameters are forwarded by calling block.
 
 @param         type        The type of request
 @param         route       The route to send the request to
 @param         append      A string to append to the route
 @param         parameters  Any parameters to the request (NSString's in the form "param=value")
 @param         data        The data of the request
 @param         contentType The content type of the data
 @param         block       Block to forward response to
 */
+ (void)sendAsynchronousRequestType:(BBRequestType)requestType
                            toRoute:(BBRequestRoute)route
                          appending:(NSString*)append
                         parameters:(NSArray*)parameters
                           withData:(NSData*)data
                        contentType:(BBContentType)contentType
                              block:(void (^)(NSURLResponse *response, NSData *data, NSError *error))block;

@end
