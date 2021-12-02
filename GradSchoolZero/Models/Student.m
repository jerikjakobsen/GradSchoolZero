//
//  Student.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "Student.h"
#import "../APIManager.h"

@implementation Student

static Student *_sharedStudent = nil;


+ (Student *) sharedStudent {
    @synchronized ([Student class]) {
        if (!_sharedStudent)
                 _sharedStudent = [[self alloc] init];
               return _sharedStudent;
           }
    return nil;
}

+ (void) applyAsStudent: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email gpa: (NSString *) gpa program: (NSString *) program gradYear: (NSString *) gradYear {
    NSDictionary *params = @{@"firstName": firstname, @"lastName": lastname, @"email": email, @"gpa": gpa, @"program": program, @"graduationYear": gradYear};
    [APIManager POST:@"signupStudentApplication" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"Sent Student Application with Code %ld", code);
    }];
}

+ (void) setSharedStudent: (NSString *) studentId {
    [APIManager GET:@"student" parameters:@{@"id": studentId} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull student, NSInteger code) {
        NSLog(@"Student %@", student);
        [Student sharedStudent].userID = student[@"id"];
        [Student sharedStudent].period = [User sharedUser].period;
        NSString *name = [[((NSString *) student[@"firstname"]) stringByAppendingString:@" "] stringByAppendingString:  ((NSString *) student[@"lastname"])];
        [Student sharedStudent].name = name;

        [Student sharedStudent].GPA = student[@"gpa"];
        [Student sharedStudent].warnings = student[@"warnings"];
            
    }];
}

@end
