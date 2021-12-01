//
//  Student.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "Student.h"
#import "../APIManager.h"

@implementation Student

+ (void) applyAsStudent: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email gpa: (NSString *) gpa program: (NSString *) program gradYear: (NSString *) gradYear {
    NSDictionary *params = @{@"firstName": firstname, @"lastName": lastname, @"email": email, @"gpa": gpa, @"program": program, @"graduationYear": gradYear};
    [APIManager POST:@"signupStudentApplication" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"Sent Student Application with Code %ld", code);
    }];
}

@end
