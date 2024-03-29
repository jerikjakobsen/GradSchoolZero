//
//  APIManager.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/29/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (void) POST: (NSString *) endpoint parameters: (NSDictionary *) params completion: (void (^)(bool succeeded, NSError * error, NSInteger code)) completion;

+ (void) POSTWithRecieving: (NSString *) endpoint parameters: (NSDictionary *) params completion: (void (^)(bool succeeded, NSError * error, NSInteger code, NSDictionary *res)) completion;

+ (void) GET: (NSString *) endpoint parameters: (NSDictionary *) params completion: (void (^)(bool succeeded, NSError * error, NSDictionary *, NSInteger code)) completion;
@end

NS_ASSUME_NONNULL_END
