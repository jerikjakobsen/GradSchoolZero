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

+ (void) login: (NSString *) type email: (NSString *) email password: (NSString *) password completion: (void (^)(bool authenticated, NSError * error, NSString * period, NSString *userID, NSString *message)) completion;

+ (void) getStudentApplications: (void (^)(bool succeeded, NSError * error, NSArray *applications)) completion;

+ (void) getInstructorApplications: (void (^)(bool succeeded, NSError * error, NSArray *applications)) completion;

+ (void) getGraduationApplications: (void (^)(bool succeeded, NSError * error, NSArray *applications)) completion;

+ (void) reviewGraduationApplication: (NSString *) appID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion;

+ (void) reviewInstructorApplication: (NSString *) appID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion;

+ (void) reviewStudentApplication: (NSString *) appID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion;

+ (void) reviewReport: (NSString *) reportID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion;
+ (void) getReports: (void (^)(bool succeeded, NSError * error, NSArray *reports)) completion;

+ (void) submitTabooWord: (NSString *) taoboWord completion: (void (^)(bool succeeded, NSError * error)) completion;

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *period;

@end

NS_ASSUME_NONNULL_END
