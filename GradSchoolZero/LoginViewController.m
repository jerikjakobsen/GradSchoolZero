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
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [User sharedUser].userID = @"1234";
    [User sharedUser].userType = @"Student";
}

@end
