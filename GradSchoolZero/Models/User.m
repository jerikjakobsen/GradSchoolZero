//
//  User.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "User.h"

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

@end
