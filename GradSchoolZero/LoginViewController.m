//
//  LoginViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 10/27/21.
//

#import "LoginViewController.h"
#import "User.h"
#import "APIManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    NSLog(@"HERE");
    NSDictionary *params = @{@"firstName": @"john", @"lastName": @"jakobsen", @"email": @"jerikjakobsen@gmail.com", @"gpa": @"4.0", @"program": @"computerscience", @"graduationYear": @"2023"};
    [APIManager POST:@"signupStudentApplication" parameters:params completion:^(bool succeeded, NSError * _Nonnull error, NSInteger code) {
        NSLog(@"Code %ld", code);
    }];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [User sharedUser].userID = @"1234";
    [User sharedUser].userType = @"Student";
}

@end
