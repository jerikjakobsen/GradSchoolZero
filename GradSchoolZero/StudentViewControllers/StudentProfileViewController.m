//
//  StudentProfileViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/2/21.
//

#import "StudentProfileViewController.h"
#import "../Models/Student.h"

@interface StudentProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentGPALabel;
@property (weak, nonatomic) IBOutlet UILabel *studentWarningsLabel;

@end

@implementation StudentProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.studentNameLabel.text = [Student sharedStudent].name;
    self.studentGPALabel.text = [NSString stringWithFormat: @"GPA: %@", [Student sharedStudent].GPA];
    self.studentWarningsLabel.text = [NSString stringWithFormat: @"Warnings: %@", [Student sharedStudent].warnings];
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
