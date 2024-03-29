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

+ (Student *) sharedStudent;

- (bool) isEqualStudent:(Student *) student;

+ (void) applyAsStudent: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email gpa: (NSString *) gpa program: (NSString *) program gradYear: (NSString *) gradYear;

+ (void) getAllStudents: (void (^)(bool succeeded, NSError *, NSArray *)) completion;

+ (void) setSharedStudent: (NSString *) studentId;

- (instancetype) initWithJson: (NSDictionary *) json;

- (void) getAvailableCourses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;

- (void) getCompletedClasses: (void (^)(bool succeeded, NSError * error, NSDictionary *)) completion;

- (void) getEnrolledCourses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;

- (void) reportProfessor: (NSString *) profID name: (NSString *) name reason: (NSString *) reason completion:(void (^)(bool succeeded, NSError * error)) completion;

- (void)reportStudent:(NSString *)studentID name: (NSString *) name reason:(NSString *)reason completion:(void (^)(bool, NSError * _Nonnull))completion;

- (void) applyForGraduation: (void (^)(bool succeeded, NSError * error, NSString *message)) completion;

- (void) joinClass: (NSString *) courseID completion: (void (^)(bool succeeded, NSError * error, NSString * message)) completion;

- (void) dropClass: (NSString *) courseID completion: (void (^)(bool succeeded, NSError * error, NSString *message)) completion;

@end

NS_ASSUME_NONNULL_END
