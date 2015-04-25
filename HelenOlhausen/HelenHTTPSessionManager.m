//
//  HelenHTTPSessionManager.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/22/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "HelenHTTPSessionManager.h"
#import "Constants.h"

@implementation HelenHTTPSessionManager

+ (HelenHTTPSessionManager *)sharedClient {
    static HelenHTTPSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HelenHTTPSessionManager alloc] init];
    });
    
    return _sharedClient;
}

- (void)getTracksWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [self GET:TRACKS_URL parameters:nil success:success failure:failure];
}

- (void)getStream:(NSString *)streamURL
         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [self GET:streamURL parameters:nil success:success failure:failure];
}

- (void)getTrackWithURL:(NSString *)trackURL
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [self GET:trackURL parameters:nil success:success failure:failure];

}

@end
