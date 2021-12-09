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
@property (strong, nonatomic) NSNumber *indexOfPeriod;
@end

@implementation RegistrarActionHubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int val = 0;
    NSArray *periods = @[ @"class setup period", @"course registration period", @"class running period", @"grading period" ];
    for (int index = 0; index < periods.count; index++) {
        if ([periods[index] isEqualToString: [User sharedUser].period]) {
            val = index;
        }
    }
    self.indexOfPeriod = @(val + 1);
    if (val == 3) {
        self.updateToLabel.text = periods[0];
        self.indexOfPeriod = @(0);
    }
    self.updateToLabel.text = [NSString stringWithFormat: @"Update to: %@", periods[self.indexOfPeriod.intValue]];
}

- (IBAction)updateSemesterPeriod:(id)sender {
    [User updatePeriod: [NSString stringWithFormat: @"%@", self.indexOfPeriod ] completion:^(bool succeeded, NSError * _Nonnull error) {
        if (succeeded) {
            self.indexOfPeriod = @(self.indexOfPeriod.intValue + 1);
            if (self.indexOfPeriod.intValue == 4) {
                self.indexOfPeriod = @(0);
            }
            NSArray *periods = @[ @"class setup period", @"course registration period", @"class running period", @"grading period" ];
            self.updateToLabel.text = [NSString stringWithFormat: @"Update to: %@", periods[self.indexOfPeriod.intValue]];
        }
    }];
    
    
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
