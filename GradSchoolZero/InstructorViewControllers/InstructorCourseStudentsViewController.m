//
//  InstructorCourseStudentsViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/5/21.
//

#import "InstructorCourseStudentsViewController.h"
#import "../Models/Instructor.h"
#import "../Table View Cells/StudentCell.h"
#import "../Models/Student.h"

@interface InstructorCourseStudentsViewController () <UITableViewDelegate, UITableViewDataSource, StudentCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *studentsTableView;
@property (nonatomic, strong) NSArray *students;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation InstructorCourseStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.topItem.title = self.course.name;
    self.studentsTableView.delegate = self;
    self.studentsTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"StudentCell" bundle:nil];
    [self.studentsTableView registerNib: nib forCellReuseIdentifier: @"StudentCell"];
    [[Instructor sharedInstructor] getStudentsForCourse: self.course.courseid completion:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull students) {
        if (succeeded) {
            self.students = students;
            [self.studentsTableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Student *student = self.students[indexPath.row];
    StudentCell *cell = [self.studentsTableView dequeueReusableCellWithIdentifier: @"StudentCell"];
    [cell configureCell: student];
    cell.delegate = self;
    if ([[User sharedUser].period isEqualToString: @"grading"]) {
        cell.action2Button.hidden = FALSE;
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count;
}

- (void)action1:(nonnull NSString *)message completion:(nonnull void (^)(NSString * _Nonnull, bool)) completion {
    // Report Student Here, Note message contains the students id
}

- (void)action2:(nonnull Student *)student completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Assign Grade" message:@"" preferredStyle: UIAlertControllerStyleAlert ];
    [alert addTextFieldWithConfigurationHandler:nil];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[Instructor sharedInstructor] assignGrade: self.course.courseid studentid:student.userID grade:alert.textFields[0].text completion:^(bool succeeded, NSError * _Nonnull error, NSString * _Nonnull message) {
            if (!succeeded) NSLog(@"%@", error.localizedDescription);
            else NSLog(@"%@", message);
        }];
    }];
    [alert addAction: action];
    [self presentViewController:alert animated:YES completion: nil];
    completion(@"Succeeded", true);
}

- (void)presentErrorMessage:(nonnull NSString *)message {
    
}

@end
