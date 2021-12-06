//
//  InstructorProfileViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/5/21.
//

#import "InstructorProfileViewController.h"
#import "../Models/Instructor.h"

@interface InstructorProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageRatingLabel;

@end

@implementation InstructorProfileViewController

- (void) viewDidAppear:(BOOL)animated {
    self.nameLabel.text = [Instructor sharedInstructor].name;
    self.warningsLabel.text = [NSString stringWithFormat:@"Warnings: %@", [Instructor sharedInstructor].warnings];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = [Instructor sharedInstructor].name;
    self.warningsLabel.text = [NSString stringWithFormat:@"Warnings: %@", [Instructor sharedInstructor].warnings];
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
