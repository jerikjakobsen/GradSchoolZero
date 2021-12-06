//
//  Instructor.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "Instructor.h"
#import "../APIManager.h"
#import "../Models/Course.h"
#import "../Models/Student.h"

@implementation Instructor

static Instructor *_sharedInstructor = nil;
bool _suspended = FALSE;

- (void) setSuspended: (bool) suspended {
    _suspended = suspended;
    
}

- (bool) isSuspended {
    return _suspended;
}

+ (Instructor *) sharedInstructor {
    @synchronized ([User class]) {
        if (!_sharedInstructor)
                 _sharedInstructor = [[self alloc] init];
               return _sharedInstructor;
           }
    return nil;
}

+ (void) applyAsInstructor: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email yoe: (NSString *) yoe program: (NSString *) program gradYear: (NSString *) gradYear {
    NSDictionary *params = @{@"firstName": firstname, @"lastName": lastname, @"email": email, @"yearsOfExperience": yoe, @"program": program, @"graduationYear": gradYear};
    [APIManager POST: @"signupInstructorApplication" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"Sent Instructor Application with Code %ld", code);
    }];
}

+ (void) setSharedInstructor: (NSString *) instructorid {
    [APIManager GET:@"getInstructor" parameters:@{@"id": instructorid} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (succeeded) {
            NSDictionary *instructor = ((NSArray *) json[@"data"])[0];
            [Instructor sharedInstructor].userID = instructor[@"id"];
            [Instructor sharedInstructor]. userType = [User sharedUser].period;
            [Instructor sharedInstructor].name = [[((NSString *) instructor[@"firstname"]) stringByAppendingString:@" "] stringByAppendingString:  ((NSString *) instructor[@"lastname"])];
            [Instructor sharedInstructor].warnings = instructor[@"warnings"];
            [[Instructor sharedInstructor] setSuspended: instructor[@"suspended"]];
        }
    }];
}

- (void) getAllInstructorCourses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion {
    [APIManager GET:@"getCoursesTaughtByProfessor" parameters:@{@"id": self.userID} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (succeeded) {
            NSArray *courses = json[@"data"];
            NSMutableArray *coursesByProf = [[NSMutableArray alloc] init];
            for (NSDictionary *c in courses) {
                [coursesByProf addObject: [[Course alloc] initWithJSON: c]];
            }
            completion(succeeded, error, coursesByProf);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

- (void) assignGrade: (NSString *) courseid studentid: (NSString *) studentid grade: (NSString *) grade completion: (void (^)(bool succeeded, NSError * error, NSString *)) completion {
    [APIManager POSTWithRecieving: @"assignGrade" parameters:@{@"studentid": studentid, @"courseid": courseid, @"grade": grade} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code, NSDictionary * _Nonnull res) {
        if (succeeded) {
            completion(succeeded, error, res[@"msg"]);
        } else {
            completion(succeeded, error, @"Error");
        }
    }];
}

- (void) getStudentsForCourse: (NSString *) courseid completion: (void (^)(bool succeeded, NSError * error, NSArray *students)) completion {
    [APIManager GET:@"getStudentsForCourse" parameters: @{@"courseid": courseid} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (succeeded) {
            NSLog(@"%@", json);
            NSArray *jsonStudents = json[@"students"];
            NSMutableArray *studentsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *s in jsonStudents) {
                [studentsArray addObject: [[Student alloc] initWithJson: s]];
            }
            completion(succeeded, error, studentsArray);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

- (void) getWaitlistedStudents: (void (^)(bool succeeded, NSError * error, NSArray *data)) completion {
    [APIManager GET:@"getWaitlistedStudents" parameters:@{@"instructorid": self.userID} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (succeeded) {
            NSMutableArray *studentsCourses = [[NSMutableArray alloc] init];
            for (NSDictionary *sc in json[@"data"]) {
                Student *s = [[Student alloc] initWithJson: sc[@"student"]];
                Course *c = [[Course alloc] initWithJSON: sc[@"course"]];
                [studentsCourses addObject: @{@"student": s, @"course": c}];
            }
            completion(succeeded, error, studentsCourses);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

- (void) reviewWaitlistedStudents: (bool) decision courseid: (NSString *) courseid studentid: (NSString *) studentid completion: (void (^)(bool succeeded, NSError * error, NSString *message)) completion {
    NSString *dec = nil;
    if (decision) dec = @"1";
    else dec = @"0";
    [APIManager POSTWithRecieving: @"reviewWaitlistedStudent" parameters:@{@"studentid": studentid, @"courseid": courseid, @"decision": dec} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code, NSDictionary * _Nonnull res) {
        if (succeeded) {
            completion(succeeded, error, res[@"msg"]);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

+ (void) getAllInstructors: (void (^)(bool succeeded, NSError * error, NSArray *)) completion {
    [APIManager GET:@"getAllInstructors" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (succeeded) {
            NSArray *instructors = json[@"instructors"];
            NSMutableArray *instructorsArr = [[NSMutableArray alloc] init];
            for (NSDictionary *iJSON in instructors) {
                Instructor *i = [[Instructor alloc] init];
                i.name =  [[((NSString *) iJSON[@"firstname"]) stringByAppendingString:@" "] stringByAppendingString:  ((NSString *) iJSON[@"lastname"])];
                i.warnings = iJSON[@"warnings"];
                [instructorsArr addObject: i];
            }
            completion(succeeded, error, instructorsArr);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

@end
