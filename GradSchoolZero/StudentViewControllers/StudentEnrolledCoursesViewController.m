//
//  StudentEnrolledCoursesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/4/21.
//

#import "StudentEnrolledCoursesViewController.h"
#import "../Models/Course.h"
#import "../Table View Cells/CourseCell.h"
#import "../Models/Student.h"

@interface StudentEnrolledCoursesViewController () <UITableViewDelegate, UITableViewDataSource, CourseCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSArray *coursesArray;


@end

@implementation StudentEnrolledCoursesViewController

- (void) viewDidAppear:(BOOL)animated {
    [self.coursesTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"CourseCell" bundle:nil];
    [self.coursesTableView registerNib: nib forCellReuseIdentifier: @"CourseCell"];

    [[Student sharedStudent] getEnrolledCourses:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull courses) {
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
    // run drop class route
}
//
//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    ((CourseCell *) cell).actionButton.titleLabel.text = [self buttonMessage];
//}

- (nonnull NSString *)buttonMessage {
    return @"Drop";
}



@end
