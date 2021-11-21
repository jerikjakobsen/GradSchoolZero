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

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userType;

@end

NS_ASSUME_NONNULL_END
