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
    while (![Student sharedStudent].name) {
        self.studentNameLabel.text = [Student sharedStudent].name;
        self.studentGPALabel.text = [NSString stringWithFormat: @"GPA: %@", [Student sharedStudent].GPA];
        self.studentWarningsLabel.text = [NSString stringWithFormat: @"Warnings: %@", [Student sharedStudent].warnings];
    }
    self.studentNameLabel.text = [Student sharedStudent].name;
    self.studentGPALabel.text = [NSString stringWithFormat: @"GPA: %@", [Student sharedStudent].GPA];
    self.studentWarningsLabel.text = [NSString stringWithFormat: @"Warnings: %@", [Student sharedStudent].warnings];
    
}

@end
