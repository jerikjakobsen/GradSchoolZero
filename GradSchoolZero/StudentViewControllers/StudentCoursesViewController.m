//
//  StudentCoursesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/2/21.
//

#import "StudentCoursesViewController.h"
#import "../Models/Course.h"
#import "../Table View Cells/CourseCell.h"
#import "../Models/Student.h"

@interface StudentCoursesViewController () <UITableViewDelegate, UITableViewDataSource, CourseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSArray *coursesArray;

@end

@implementation StudentCoursesViewController

- (void) viewDidAppear:(BOOL)animated {
    [[Student sharedStudent] getAvailableCourses:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull courses) {
        if (error == nil) {
            self.coursesArray = courses;

            [self.coursesTableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"CourseCell" bundle:nil];
    [self.coursesTableView registerNib: nib forCellReuseIdentifier: @"CourseCell"];

    [[Student sharedStudent] getAvailableCourses:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull courses) {
        if (error == nil) {
            self.coursesArray = courses;

            [self.coursesTableView reloadData];
        }
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"CourseCell" forIndexPath:indexPath];
    Course *course = self.coursesArray[indexPath.row];
    cell.delegate = self;
    [cell configureCell: course];
    [cell.actionButton setHidden: FALSE];
    cell.actionButton.enabled = TRUE;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.coursesArray.count;
}


- (void)presentErrorMessage:(nonnull NSString *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction: action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)buttonAction:(nonnull NSString *)courseID completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    [[Student sharedStudent] joinClass: courseID completion:^(bool succeeded, NSError * _Nonnull error, NSString * _Nonnull message) {
        completion(message, succeeded);
    }];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ((CourseCell *) cell).actionButton.titleLabel.text = [self buttonMessage];
}

- (NSString *)buttonMessage {
    return @"Join";
}

@end
