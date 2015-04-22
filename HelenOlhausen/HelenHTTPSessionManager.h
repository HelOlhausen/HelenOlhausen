//
//  HelenHTTPSessionManager.h
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/22/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HelenHTTPSessionManager : AFHTTPSessionManager

+ (HelenHTTPSessionManager *)sharedClient;

- (void)getTracksWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getStream:(NSString *)streamURL
          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
