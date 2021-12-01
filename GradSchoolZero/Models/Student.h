//
//  Student.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : User

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *GPA;
@property (nonatomic, strong) NSNumber *warnings;

// Add more details to applyAsStudent
+ (void) applyAsStudent: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email gpa: (NSString *) gpa program: (NSString *) program gradYear: (NSString *) gradYear;

+ (void) getAllStudents: (void (^)(bool succeeded, NSError *, NSArray *)) completion;

- (void) getAllClasses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;

- (void) getCurrentClasses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;

- (void) reportProfessor: (NSString *) profID reason: (NSString *) reason completion:(void (^)(bool succeeded, NSError * error)) completion;

- (void) reportStudent: (NSString *) studentID reason: (NSString *) reason completion: (void (^)(bool succeeded, NSError * error)) completion;

- (void) applyForGraduation: (void (^)(bool succeeded, NSError * error)) completion;

- (void) joinClass: (NSString *) courseID completion: (void (^)(bool succeeded, NSError * error)) completion;

- (void) dropClass: (NSString *) courseID completion: (void (^)(bool succeeded, NSError * error)) completion;

@end

NS_ASSUME_NONNULL_END
