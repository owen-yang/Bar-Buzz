//
//  BBNetworking.m
//  Bar Buzz
//
//  Created by Owen Yang on 5/16/15.
//  Copyright (c) 2015 Bar Buzz. All rights reserved.
//

#import "BBNetworking.h"

NSString *const BB_API_TOKEN = @"09783d0168e8296aad2b436d5df8d2a3dedd13d3575de56ccfe849a9a9865898";

@implementation BBNetworking

+ (NSString*)requestTypeToString:(BBRequestType)type {
    switch (type) {
        case BBRequestTypePOST:
            return @"POST";
        case BBRequestTypeGET:
            return @"GET";
        case BBRequestTypePUT:
            return @"PUT";
        case BBRequestTypeDELETE:
            return @"DELETE";
    }
}

+ (NSString*)requestRouteToString:(BBRequestRoute)route {
    switch (route) {
        case BBRequestRouteAPIBars:
            return @"/api/bars/";
        case BBRequestRouteAPIBarsLocate:
            return @"/api/bars/locate/";
    }
}

+ (NSString*)contentTypeToString:(BBContentType)type {
    switch (type) {
        case BBContentTypeJSON:
            return @"application/json";
    }
}

+ (void)sendAsynchronousRequestType:(BBRequestType)requestType
                            toRoute:(BBRequestRoute)route
                          appending:(NSString*)append
                         parameters:(NSArray*)parameters
                       withJSONBody:(NSDictionary*)body
                              block:(void (^)(NSURLResponse *response, NSData *data, NSError *error))block
{
    NSData *data;
    NSError *error;
    if (body) {
        data = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    }
    
    if (!error) {
        [BBNetworking sendAsynchronousRequestType:requestType toRoute:route appending:append parameters:parameters withData:data contentType:BBContentTypeJSON block:block];
    } else {
        NSLog(@"JSON Serialization Failed");
        block(nil, nil, error);
    }
}

+ (void)sendAsynchronousRequestType:(BBRequestType)requestType
                            toRoute:(BBRequestRoute)route
                          appending:(NSString*)append
                         parameters:(NSArray*)parameters
                           withData:(NSData*)data
                        contentType:(BBContentType)contentType
                              block:(void (^)(NSURLResponse *response, NSData *data, NSError *error))block
{
    NSString *requestTypeString = [BBNetworking requestTypeToString:requestType];
    NSString *requestRouteString = [BBNetworking requestRouteToString:route];
    NSString *contentTypeString = [BBNetworking contentTypeToString:contentType];
#warning Change URL string
    NSMutableString *requestURLString = [NSMutableString stringWithFormat:@"http://45.55.151.250%@", requestRouteString];
    if (append) {
        [requestURLString appendString:append];
    }
    if (parameters) {
        [requestURLString appendString:@"?"];
        for (int i = 0; i < parameters.count; ++i) {
            if (i != 0) {
                [requestURLString appendString:@"&"];
            }
            [requestURLString appendString:parameters[i]];
        }
    }
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    request.allHTTPHeaderFields = @{@"x-access-token"   : BB_API_TOKEN,
                                    @"Content-Type"     : contentTypeString};
    request.HTTPMethod = requestTypeString;
    request.HTTPBody = data;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (block) block(response, data, connectionError);
    }];
}

@end
