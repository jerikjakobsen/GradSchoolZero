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
    [User login: userType email: self.emailField.text password: self.passwordField.text completion:^(bool authenticated, NSError * _Nonnull error, NSString * _Nonnull period, NSString *userID, NSString *message) {
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
                [Instructor setSharedInstructor: userID];
                if ([period isEqualToString: @"pre-registration"]) {
                    [self performSegueWithIdentifier:@"toInstructor" sender:self];
                } else if ([period isEqualToString: @"registration"] || [period isEqualToString: @"special-registration"]) {
                    [self performSegueWithIdentifier:@"toInstructor" sender:self];
                } else if ([period isEqualToString: @"course-run"]) {
                    [self performSegueWithIdentifier:@"toInstructor" sender:self];
                } else if ([period isEqualToString: @"review"]) {
                    [self performSegueWithIdentifier:@"toInstructor" sender:self];
                } else if ([period isEqualToString:@"grading"]) {
                    [self performSegueWithIdentifier:@"toInstructor" sender:self];
                }
            } else {
                if ([period isEqualToString: @"pre-registration"]) {
                    [self performSegueWithIdentifier:@"toRegistrar" sender:self];
                } else if ([period isEqualToString: @"registration"] || [period isEqualToString: @"special-registration"]) {
                    [self performSegueWithIdentifier:@"toRegistrar" sender:self];
                } else if ([period isEqualToString: @"course-run"]) {
                    [self performSegueWithIdentifier:@"toRegistrar" sender:self];
                } else if ([period isEqualToString: @"review"]) {
                    [self performSegueWithIdentifier:@"toRegistrar" sender:self];
                } else if ([period isEqualToString:@"grading"]) {
                    [self performSegueWithIdentifier:@"toRegistrar" sender:self];
                }
            }
            
            
        } else {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle: UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction: action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

@end
