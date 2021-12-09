//
//  User.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "User.h"
#import "../APIManager.h"
#import "Student.h"

@implementation User

static User *_sharedUser = nil;

+ (User *) sharedUser {
    @synchronized ([User class]) {
        if (!_sharedUser)
                 _sharedUser = [[self alloc] init];
               return _sharedUser;
           }
    return nil;
}

+ (void) login: (NSString *) type email: (NSString *) email password: (NSString *) password completion: (void (^)(bool authenticated, NSError * error, NSString * period, NSString *userID, NSString *message)) completion {
    NSDictionary *params = @{@"email": email, @"password": password, @"type": type};
    [APIManager POSTWithRecieving:@"login" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code, NSDictionary * _Nonnull res) {
       
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            completion(false, error, nil, nil, @"Error Logging In");
        } else {
            if ([res[@"auth"] isEqualToString: @"true"]) {
                [User sharedUser].userID = res[@"id"];
                [User sharedUser].userType = type;
                [User sharedUser].period = res[@"period"];
                completion(res[@"auth"], nil, res[@"period"], res[@"id"], @"Success!");
            }
        }
    }];
}

+ (void) getStudentApplications: (void (^)(bool succeeded, NSError * error, NSArray *applications)) completion {
    [APIManager GET:@"getStudentApplications" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull apps, NSInteger code) {
        if (succeeded) {
            completion(succeeded, error, apps[@"data"]);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

+ (void) getInstructorApplications: (void (^)(bool succeeded, NSError * error, NSArray *applications)) completion {
    [APIManager GET:@"getInstructorApplications" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull apps, NSInteger code) {
        if (succeeded) {
            completion(succeeded, error, apps[@"data"]);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

+ (void) getGraduationApplications: (void (^)(bool succeeded, NSError * error, NSArray *applications)) completion {
    [APIManager GET:@"getGraduationApplications" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull apps, NSInteger code) {
        if (succeeded) {
            NSArray *studentApps = apps[@"data"];
            int __block val = 0;
            bool __block success = TRUE;
            NSMutableArray* studentWithApps = [[NSMutableArray alloc] init];
            for (NSDictionary *app in studentApps) {
                [APIManager GET:@"student" parameters:@{@"id": app[@"studentid"]} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull student, NSInteger code) {
                    if (!succeeded) {
                        success = FALSE;
                        completion(NO, error, nil);
                    }
                    if (success && succeeded) {
                        Student *s = [[Student alloc] initWithJson: student];
                        NSDictionary *studentWithApp = @{@"student": s, @"appID": app[@"id"]};
                        [studentWithApps addObject: studentWithApp];
                        if (val == studentApps.count - 1) {
                            completion(YES, error, studentWithApps);
                        } else {
                            val++;
                        }
                    }
                }];
            }
        } else {
            completion(NO, error, nil);
        }
    }];
}

+ (void) reviewStudentApplication: (NSString *) appID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion {
    NSString *dec = @"";
    if (decision) {
        dec = @"0";
    } else {
        dec = @"1";
    }
    [APIManager POST:@"reviewStudentApplication" parameters:@{@"id": appID, @"decision": dec} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        completion(succeeded, error);
    }];
}

+ (void) reviewInstructorApplication: (NSString *) appID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion {
    NSString *dec = @"";
    if (decision) {
        dec = @"0";
    } else {
        dec = @"1";
    }
    [APIManager POST:@"reviewInstructorApplication" parameters:@{@"id": appID, @"decision": dec} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        completion(succeeded, error);
    }];
}

+ (void) reviewGraduationApplication: (NSString *) appID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion {
    NSString *dec = @"";
    if (decision) {
        dec = @"0";
    } else {
        dec = @"1";
    }
    [APIManager POST:@"reviewGraduationApplication" parameters:@{@"studentid": appID, @"decision": dec} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"%ld", code);
        completion(succeeded, error);
    }];
}

+ (void) reviewReport: (NSString *) reportID decision: (bool) decision completion: (void (^)(bool succeeded, NSError * error)) completion {
    NSString *dec = @"";
    if (decision) {
        dec = @"1";
    } else {
        dec = @"0";
    }
    [APIManager POST:@"reviewReport" parameters:@{@"id": reportID, @"decision": dec} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"%ld", code);
        completion(succeeded, error);
    }];
}

+ (void) getReports: (void (^)(bool succeeded, NSError * error, NSArray *reports)) completion {
    [APIManager GET:@"getReports" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull apps, NSInteger code) {
        if (succeeded) {
            completion(succeeded, error, apps[@"data"]);
        } else {
            completion(succeeded, error, nil);
        }
    }];
}

+ (void) submitTabooWord: (NSString *) tabooWord completion: (void (^)(bool succeeded, NSError * error)) completion {
    [APIManager POST:@"addTabooWords" parameters:@{@"taboo": tabooWord} completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        completion(succeeded, error);
    }];
}


@end
