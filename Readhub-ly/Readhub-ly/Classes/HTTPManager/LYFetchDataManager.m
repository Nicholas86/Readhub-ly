//
//  LYFetchDataManager.m
//  Readhub-ly
//
//  Created by 刘毅 on 2018/3/25.
//  Copyright © 2018年 halohily.com. All rights reserved.
//

#import "LYFetchDataManager.h"
#import "AFNetworking.h"

static NSString * const kReadhubBaseURL = @"https://api.readhub.me/";

static LYFetchDataManager * _instance;

@interface LYFetchDataManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation LYFetchDataManager

#pragma mark - Singletn
+ (instancetype)sharedInstance {
    return [[LYFetchDataManager alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", nil];
    }
    return _manager;
}

#pragma mark - fetch data

- (void)sendRequestByParameters:(NSDictionary *)parameters success:(nullable void (^)(id _Nonnull responseObject))success failure:(nullable void (^)(NSError * _Nonnull error))failure{
    id type = parameters[@"type"];
    ReadhubDataType dataType = [type integerValue];
    NSString *typeString;
    switch (dataType) {
        case ReadhubTopic:
            typeString = @"topic";
            break;
        case ReadhubNews:
            typeString = @"news";
            break;
        case ReadhubTechNews:
            typeString = @"technews";
            break;
        case ReadhubBlockChain:
            typeString = @"blockchain";
            break;
        default:
            typeString = @"topic";
            break;
    };
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kReadhubBaseURL, typeString];
    NSString *ID = parameters[@"id"];
    NSMutableDictionary *requestParams;
    if (ID) {
        urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"/%@", ID]];
        requestParams = nil;
    }
    else {
        requestParams = [NSMutableDictionary new];
        [requestParams setValue:@(20) forKey:@"pageSize"];
        NSString *lastCursor = parameters[@"lastCursor"];
        if (lastCursor) {
            [requestParams setValue:lastCursor forKey:@"lastCursor"];
        }
    }
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.manager GET:urlString parameters:requestParams progress:^(NSProgress * _Nonnull downloadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *encoding = [[task response] textEncodingName];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)readHubDataByType:(ReadhubDataType)type lastCursor:(NSString *)lastCursor success:(nullable void (^)(id _Nonnull responseObject))success failure:(nullable void (^)(NSError * _Nonnull error))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:@(type) forKey:@"type"];
    if (lastCursor) {
        [parameters setValue:lastCursor forKey:@"lastCursor"];
    }
    [self sendRequestByParameters:parameters success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    return;
}

- (void)readHubDetailByType:(ReadhubDataType)type dataID:(NSString *)ID success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:@(type) forKey:@"type"];
    [parameters setValue:ID forKey:@"id"];
    
    [self sendRequestByParameters:parameters success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    return;
}

@end
