//
//  ApplyAsStudentViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/30/21.
//

#import "ApplyAsStudentViewController.h"
#import "../Models/Student.h"

@interface ApplyAsStudentViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *programField;
@property (weak, nonatomic) IBOutlet UITextField *GPAField;
@property (weak, nonatomic) IBOutlet UITextField *gradYearField;

@end

@implementation ApplyAsStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction) apply: (id) sender {
    [Student applyAsStudent: self.firstNameField.text lastname:self.lastNameField.text email:self.emailField.text gpa:self.GPAField.text program:self.programField.text gradYear:self.gradYearField.text];
    [self dismissViewControllerAnimated:YES completion:^{}];
}
- (IBAction)didCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
