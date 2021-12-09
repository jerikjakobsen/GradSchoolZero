//
//  RegistrarActionHubViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import "RegistrarActionHubViewController.h"
#import "../Models/User.h"

@interface RegistrarActionHubViewController ()

@property (weak, nonatomic) IBOutlet UILabel *updateToLabel;
@property (weak, nonatomic) IBOutlet UITextField *wordCreationTextField;

@end

@implementation RegistrarActionHubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)updateSemesterPeriod:(id)sender {
    
}

- (IBAction)createTabooWord:(id)sender {
    [User submitTabooWord: self.wordCreationTextField.text completion:^(bool succeeded, NSError * _Nonnull error) {
            if (succeeded) {
                self.wordCreationTextField.text = @"";
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Error Occurred" message:@"Try again" preferredStyle: UIAlertControllerStyleAlert ];
                [alert addTextFieldWithConfigurationHandler:nil];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction: action];
                [self presentViewController:alert animated:YES completion: nil];
            }
    }];
}

@end
