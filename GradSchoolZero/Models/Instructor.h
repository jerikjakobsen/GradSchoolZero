//
//  Instructor.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Instructor : User

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *warnings;
- (bool) isSuspended;
- (void) setSuspended: (bool) suspended;

+ (Instructor *) sharedInstructor;

//Need to add more

//Add more details to applyAsInstructor
+ (void) applyAsInstructor: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email yoe: (NSString *) yoe program: (NSString *) program gradYear: (NSString *) gradYear;

+ (void) setSharedInstructor: (NSString *) instructorid;

+ (void) getAllInstructors: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;

- (void) getAllInstructorCourses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;

- (void) assignGrade: (NSString *) courseid studentid: (NSString *) studentid grade: (NSString *) grade completion: (void (^)(bool succeeded, NSError * error, NSString *)) completion;

- (void) getStudentsForCourse: (NSString *) courseid completion: (void (^)(bool succeeded, NSError * error, NSArray *students)) completion;

- (void) getWaitlistedStudents: (void (^)(bool succeeded, NSError * error, NSArray *data)) completion;

- (void) reviewWaitlistedStudents: (bool) decision courseid: (NSString *) courseid studentid: (NSString *) studentid completion: (void (^)(bool succeeded, NSError * error, NSString *message)) completion;
- (void)reportStudent:(NSString *)studentID name: (NSString *) name reason:(NSString *)reason completion:(void (^)(bool, NSError * _Nonnull))completion;
@end

NS_ASSUME_NONNULL_END
