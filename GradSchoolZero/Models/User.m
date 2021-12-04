//
//  User.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "User.h"
#import "../APIManager.h"

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

+ (void) login: (NSString *) type email: (NSString *) email password: (NSString *) password completion: (void (^)(bool authenticated, NSError * error, NSString * period, NSString *userID)) completion {
    NSDictionary *params = @{@"email": email, @"password": password, @"type": type};
    [APIManager POSTWithRecieving:@"login" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code, NSDictionary * _Nonnull res) {
       
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            completion(false, error, nil, nil);
        } else {
            if ([res[@"auth"] isEqualToString: @"true"]) {
                [User sharedUser].userID = res[@"id"];
                [User sharedUser].userType = type;
                [User sharedUser].period = res[@"period"];
                completion(res[@"auth"], nil, res[@"period"], res[@"id"]);
            }
            completion(false, nil,@"", @"");
        }
    }];
}

@end
