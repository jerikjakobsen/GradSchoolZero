//
//  RegistrarStudentProfileViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import "RegistrarStudentProfileViewController.h"
#import "../Models/Student.h"
#import "../Models/Course.h"
#import "../Table View Cells/ClassCell.h"

@interface RegistrarStudentProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningsLabel;
@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSDictionary *courses;

@end

@implementation RegistrarStudentProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    self.nameLabel.text = self.student.name;
    self.gpaLabel.text = [NSString stringWithFormat: @"GPA %@", self.student.GPA];
    self.warningsLabel.text = [NSString stringWithFormat: @"Warnings %@", self.student.warnings];
    [self.student getCompletedClasses:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json) {
        if (succeeded) {
            self.courses = json;
            [self.coursesTableView reloadData];
        }
    }];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ClassCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"ClassCell"];
    NSDictionary *class = self.courses[@"classes"][indexPath.row];
    Course *course = self.courses[@"courses"][indexPath.row];
    [cell configureCell:course classInfo:class];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *) self.courses[@"courses"]).count;
}

@end
