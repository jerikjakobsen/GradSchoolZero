//
//  Instructor.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Instructor : User

//Need to add more

//Add more details to applyAsInstructor
+ (void) applyAsInstructor;

+ (void) getAllInstructors: (void (^)(bool succeeded, NSError * error, NSArray *)) completion;



@end

NS_ASSUME_NONNULL_END
