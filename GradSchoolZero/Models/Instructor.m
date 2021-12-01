//
//  Instructor.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "Instructor.h"
#import "../APIManager.h"

@implementation Instructor

+ (void) applyAsInstructor: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email yoe: (NSString *) yoe program: (NSString *) program gradYear: (NSString *) gradYear {
    NSDictionary *params = @{@"firstName": firstname, @"lastName": lastname, @"email": email, @"yearsOfExperience": yoe, @"program": program, @"graduationYear": gradYear};
    [APIManager POST: @"signupInstructorApplication" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"Sent Instructor Application with Code %ld", code);
    }];
}

@end
