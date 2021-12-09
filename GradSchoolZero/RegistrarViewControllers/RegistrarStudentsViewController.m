//
//  RegistrarStudentsViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/7/21.
//

#import "RegistrarStudentsViewController.h"
#import "../Models/Student.h"
#import "../Table View Cells/StudentCell.h"
#import "RegistrarStudentProfileViewController.h"

@interface RegistrarStudentsViewController () <StudentCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *studentsTableView;
@property (strong, nonatomic) NSArray *students;

@end

@implementation RegistrarStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName: @"StudentCell" bundle: nil];
    [self.studentsTableView registerNib: nib forCellReuseIdentifier:@"StudentCell"];
    self.studentsTableView.delegate = self;
    self.studentsTableView.dataSource = self;
    [Student getAllStudents:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull students) {
        if (succeeded) {
            self.students = students;
            [self.studentsTableView reloadData];
        }
    }];
    
}

- (void)action1:(nonnull NSString *)message completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    // Drop student from school;
}

- (void)action2:(nonnull NSString *)message completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    // Do nothing
}

- (void)presentErrorMessage:(nonnull NSString *)message {
    // Present error message;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StudentCell *cell = [self.studentsTableView dequeueReusableCellWithIdentifier: @"StudentCell"];
    Student *s = self.students[indexPath.row];
    [cell configureCell: s];
    cell.action1Button.hidden = TRUE;
    cell.action1Button.titleLabel.text = @"Expell";
    cell.action2Button.hidden = true;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toStudentProfile" sender: self.students[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RegistrarStudentProfileViewController *vc = segue.destinationViewController;
    vc.student = sender;
}

@end
