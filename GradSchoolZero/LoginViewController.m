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
#import "Models/Student.h"
#import "Models/Instructor.h"

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
    NSString* userType = types[[self.userTypeSegment selectedSegmentIndex]];
    [User login: userType email: self.emailField.text password: self.passwordField.text completion:^(bool authenticated, NSError * _Nonnull error, NSString * _Nonnull period, NSString *userID) {
        NSLog(@"period");
        if (authenticated) {
            self.emailField.text = @"";
            self.passwordField.text = @"";
            if ([userType isEqualToString: @"student"]) {
                [Student setSharedStudent: userID];
                if ([period isEqualToString: @"pre-registration"]) {
                    [self performSegueWithIdentifier:@"toStudent" sender: self];
                } else if ([period isEqualToString: @"registration"] || [period isEqualToString: @"special-registration"]) {
                    [self performSegueWithIdentifier:@"toStudent" sender: self];
                } else if ([period isEqualToString: @"course-run"]) {
                    [self performSegueWithIdentifier:@"toStudent" sender: self];
                } else if ([period isEqualToString: @"review"]) {
                    [self performSegueWithIdentifier:@"toStudent" sender: self];
                } else if ([period isEqualToString:@"grading"]) {
                    [self performSegueWithIdentifier:@"toStudent" sender: self];
                }
            } else if ([userType isEqualToString: @"instructor"]) {
                if ([period isEqualToString: @"pre-registration"]) {
                    
                } else if ([period isEqualToString: @"registration"] || [period isEqualToString: @"special-registration"]) {
                    
                } else if ([period isEqualToString: @"course-run"]) {
                    
                } else if ([period isEqualToString: @"review"]) {
                    
                } else if ([period isEqualToString:@"grading"]) {
                    
                }
            } else {
                if ([period isEqualToString: @"pre-registration"]) {
                    
                } else if ([period isEqualToString: @"registration"] || [period isEqualToString: @"special-registration"]) {
                    
                } else if ([period isEqualToString: @"course-run"]) {
                    
                } else if ([period isEqualToString: @"review"]) {
                    
                } else if ([period isEqualToString:@"grading"]) {
                    
                }
            }
            
            
        } else {
            
        }
    }];
}

@end
