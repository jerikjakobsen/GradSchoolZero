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
    cell.joinClassButton.titleLabel.text = @"Drop Class";
    [cell.joinClassButton setHidden: FALSE];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.coursesArray.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)presentErrorMessage:(nonnull NSString *)message {
    // DO something here (For drop class? )
}

@end
