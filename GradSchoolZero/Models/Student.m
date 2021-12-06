//
//  Student.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "Student.h"
#import "../APIManager.h"
#import "Course.h"

@implementation Student

static Student *_sharedStudent = nil;

- (bool) isEqualStudent:(Student *) student {
    return [self.userID isEqualToString:student.userID];
}

+ (Student *) sharedStudent {
    @synchronized ([Student class]) {
        if (!_sharedStudent)
                 _sharedStudent = [[self alloc] init];
               return _sharedStudent;
           }
    return nil;
}

+ (void) getAllStudents: (void (^)(bool succeeded, NSError *, NSArray *)) completion {
    [APIManager GET:@"students" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        NSMutableArray *students = [[NSMutableArray alloc] init];
        for (NSDictionary *student in json[@"students"]) {
            Student *s = [[Student alloc] initWithJson: student];
            [students addObject: s];
        }
        completion(succeeded, error, students);
    }];
}

+ (void) applyAsStudent: (NSString *) firstname lastname: (NSString *) lastname email: (NSString *) email gpa: (NSString *) gpa program: (NSString *) program gradYear: (NSString *) gradYear {
    NSDictionary *params = @{@"firstName": firstname, @"lastName": lastname, @"email": email, @"gpa": gpa, @"program": program, @"graduationYear": gradYear};
    [APIManager POST:@"signupStudentApplication" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"Sent Student Application with Code %ld", code);
    }];
}

+ (void) setSharedStudent: (NSString *) studentId {
    [APIManager GET:@"student" parameters:@{@"id": studentId} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull student, NSInteger code) {
        [Student sharedStudent].userID = student[@"id"];
        [Student sharedStudent].period = [User sharedUser].period;
        NSString *name = [[((NSString *) student[@"firstname"]) stringByAppendingString:@" "] stringByAppendingString:  ((NSString *) student[@"lastname"])];
        [Student sharedStudent].name = name;
        [Student sharedStudent].GPA = student[@"gpa"];
        [Student sharedStudent].warnings = student[@"warnings"];
    }];
}

- (instancetype) initWithJson: (NSDictionary *) json {
    if (self = [super init]) {
        self.userID = json[@"id"];
        self.name =  [[((NSString *) json[@"firstname"]) stringByAppendingString:@" "] stringByAppendingString:  ((NSString *) json[@"lastname"])];
        self.userType = @"student";
        self.GPA = json[@"gpa"];
        self.warnings = json[@"warnings"];
    }
    return self;
    
}

- (void) getAvailableCourses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion {
    [APIManager GET: @"availableCourses" parameters:@{@"studentid": self.userID} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (error == nil) {
            NSMutableArray *courses = [[NSMutableArray alloc] init];
            for (NSDictionary *course in json[@"courses"]) {
                [courses addObject:  [[Course alloc] initWithJSON: course]];
            }
            completion(true, error, courses);
        } else {
            completion(false, error, nil);
        }
    }];
}

- (void) getCompletedClasses: (void (^)(bool succeeded, NSError * error, NSDictionary *)) completion {
    [APIManager GET: @"completedCourses" parameters:@{@"studentid": self.userID} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (error == nil) {
            NSMutableArray *courses = [[NSMutableArray alloc] init];
            for (NSDictionary *class in json[@"classes"]) {
                [courses addObject:  [[Course alloc] initWithJSON: class[@"course"]]];
            }
            NSDictionary *dict = @{@"classes": json[@"classes"], @"courses": courses};
            completion(true, error, dict);
        } else {
            completion(false, error, nil);
        }
    }];
}

- (void) getEnrolledCourses: (void (^)(bool succeeded, NSError * error, NSArray *)) completion {
    [APIManager GET: @"enrolledCourses" parameters:@{@"studentid": self.userID} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json, NSInteger code) {
        if (error == nil) {
            NSMutableArray *courses = [[NSMutableArray alloc] init];
            for (NSDictionary *course in json[@"courses"]) {
                [courses addObject:  [[Course alloc] initWithJSON: course]];
            }
            completion(true, error, courses);
        } else {
            completion(false, error, nil);
        }
    }];
}

- (void) joinClass: (NSString *) courseID completion: (void (^)(bool succeeded, NSError * error, NSString * message)) completion {
    [APIManager POSTWithRecieving:@"enroll" parameters: @{@"studentid": self.userID, @"courseid": courseID} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code, NSDictionary * _Nonnull res) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            completion(false, error, @"Something went Wrong");
        } else {
            if (code == 200) {
                completion(true, nil, @"Success!");
            } else {
                completion(false, nil, res[@"msg"]);
            }
        }
    }];
}

- (void) dropClass: (NSString *) courseID completion: (void (^)(bool succeeded, NSError * error, NSString *message)) completion {
    [APIManager POSTWithRecieving:@"dropCourse" parameters:@{@"courseid": courseID, @"studentid": self.userID} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code, NSDictionary * _Nonnull res) {
        if (error != nil) {
            completion(succeeded, error, nil);
        } else {
            completion(succeeded, error, res[@"msg"]);
        }
    }];
}

@end
