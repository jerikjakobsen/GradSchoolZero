//
//  LoginViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 10/27/21.
//

#import "LoginViewController.h"
#import "User.h"
#import "APIManager.h"
#import "Models/Course.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userTypeSegment;

@end

@implementation LoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)didLogin:(id)sender {
    NSArray *types = @[@"student", @"instructor", @"registrar"];
    [User login: types[[self.userTypeSegment selectedSegmentIndex]] email:@"jerikjakobsen@gmail.com" password:@"1234" completion:^(bool authenticated, NSError * _Nonnull error, NSString * _Nonnull period, NSString *userID) {
            // Do proper transitions based on the user type and period
        NSLog(@"id:%@", userID);
    }];
}

@end
