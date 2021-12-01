//
//  ApplyAsInstructorViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/30/21.
//

#import "ApplyAsInstructorViewController.h"
#import "../Models/Instructor.h"

@interface ApplyAsInstructorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *programField;
@property (weak, nonatomic) IBOutlet UITextField *yoeField;
@property (weak, nonatomic) IBOutlet UITextField *gradYearField;

@end

@implementation ApplyAsInstructorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didApply:(id)sender {
    [Instructor applyAsInstructor:self.firstNameField.text lastname:self.lastNameField.text email:self.emailField.text yoe:self.yoeField.text program:self.programField.text gradYear:self.gradYearField.text];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)didCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
