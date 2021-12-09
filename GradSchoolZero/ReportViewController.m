//
//  ReportViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/6/21.
//

#import "ReportViewController.h"
#import "Table View Cells/StudentCell.h"
#import "Table View Cells/InstructorCell.h"
#import "Models/Student.h"
#import "Models/Instructor.h"

@interface ReportViewController () <UITableViewDelegate, UITableViewDataSource, StudentCellDelegate, InstructorCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *studentsAndInstructorsTableView;
@property (strong, nonatomic) NSArray *students;
@property (strong, nonatomic) NSArray *instructors;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentsAndInstructorsTableView.delegate = self;
    self.studentsAndInstructorsTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"StudentCell" bundle:nil];
    [self.studentsAndInstructorsTableView registerNib:nib forCellReuseIdentifier:@"StudentCell"];
    UINib *nib2 = [UINib nibWithNibName:@"InstructorCell" bundle:nil];
    [self.studentsAndInstructorsTableView registerNib:nib2 forCellReuseIdentifier:@"InstructorCell"];
    if (![[User sharedUser].userType isEqualToString: @"instructor"]) {
        [Instructor getAllInstructors:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull instructors) {
            if (succeeded) {
                self.instructors = instructors;
                [self.studentsAndInstructorsTableView reloadData];
            }
        }];
    }
    [Student getAllStudents:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull students) {
        if (succeeded) {
            self.students = students;
            [self.studentsAndInstructorsTableView reloadData];
        }
    }];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        StudentCell *cell = [self.studentsAndInstructorsTableView dequeueReusableCellWithIdentifier: @"StudentCell" forIndexPath:indexPath];
        Student *s = self.students[indexPath.row];
        cell.delegate = self;
        [cell configureCell: s];
        cell.action2Button.hidden = TRUE;
        return cell;
    }
    
    if (indexPath.section == 1) {
        InstructorCell *cell = [self.studentsAndInstructorsTableView dequeueReusableCellWithIdentifier: @"InstructorCell" forIndexPath:indexPath];
        Instructor *i = self.instructors[indexPath.row];
        [cell configureCell: i];
        cell.delegate = self;
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return self.students.count;
    else return self.instructors.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Students";
    if (section == 1) return @"Instructors";
    return @"";
}

- (void)action1:(nonnull Student *)student completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    if ([[User sharedUser].userType isEqualToString: @"student"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Report Student" message:@"Write Complaint" preferredStyle: UIAlertControllerStyleAlert ];
        [alert addTextFieldWithConfigurationHandler:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[Student sharedStudent] reportStudent:student.userID name:student.name reason:alert.textFields[0].text completion:^(bool succeeded, NSError * _Nonnull error) {
                    if (!succeeded) NSLog(@"%@", error.localizedDescription);
            }];
        }];
        [alert addAction: action];
        [self presentViewController:alert animated:YES completion: nil];
    }
    if ([[User sharedUser].userType isEqualToString: @"instructor"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Report Student" message:@"Write Complaint" preferredStyle: UIAlertControllerStyleAlert ];
        [alert addTextFieldWithConfigurationHandler:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[Instructor sharedInstructor] reportStudent:student.userID name:student.name reason:alert.textFields[0].text completion:^(bool succeeded, NSError * _Nonnull error) {
                    if (!succeeded) NSLog(@"%@", error.localizedDescription);
            }];
        }];
        [alert addAction: action];
        [self presentViewController:alert animated:YES completion: nil];
    }
}

- (void)action2:(nonnull Student *)student completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    // DO NOTHING
}

- (void)presentErrorMessage:(nonnull NSString *)message {
    // DO NOTHING
}

- (void)didTapAction1:(nonnull Instructor *)instructor {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Report Instructor" message:@"Write Complaint" preferredStyle: UIAlertControllerStyleAlert ];
    [alert addTextFieldWithConfigurationHandler:nil];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[Student sharedStudent] reportProfessor:instructor.userID name:instructor.name reason:alert.textFields[0].text completion:^(bool succeeded, NSError * _Nonnull error) {
                if (!succeeded) NSLog(@"%@", error.localizedDescription);
        }];
    }];
    [alert addAction: action];
    [self presentViewController:alert animated:YES completion: nil];
}

@end
