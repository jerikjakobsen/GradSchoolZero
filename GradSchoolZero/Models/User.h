//
//  User.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

+ (User *) sharedUser;

+ (void) login: (NSString *) type email: (NSString *) email password: (NSString *) password completion: (void (^)(bool authenticated, NSError * error, NSString * period, NSString *userID)) completion;

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *period;


@end

NS_ASSUME_NONNULL_END
