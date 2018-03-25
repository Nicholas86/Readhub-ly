//
//  LYFetchDataManager.h
//  Readhub-ly
//
//  Created by 刘毅 on 2018/3/25.
//  Copyright © 2018年 halohily.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ReadhubDataType) {
    ReadhubTopic,
    ReadhubNews,
    ReadhubTechNews,
    ReadhubBlockChain
};

NS_ASSUME_NONNULL_BEGIN

@interface LYFetchDataManager : NSObject

+ (instancetype)sharedInstance;

- (void)readHubDataByType:(ReadhubDataType)type lastCursor:(nullable NSString *)lastCursor success:(nullable void (^)(id _Nonnull responseObject))success failure:(nullable void (^)(NSError * _Nonnull error))failure;

- (void)readHubDetailByType:(ReadhubDataType)type dataID:(NSString *)ID success:(nullable void (^)(id _Nonnull responseObject))success failure:(nullable void (^)(NSError * _Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
