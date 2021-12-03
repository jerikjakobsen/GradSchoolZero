//
//  StudentCoursesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/2/21.
//

#import "StudentCoursesViewController.h"
#import "../Models/Course.h"
#import "../Table View Cells/CourseCell.h"

@interface StudentCoursesViewController () <UITableViewDelegate, UITableViewDataSource, CourseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSArray *coursesArray;

@end

@implementation StudentCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"CourseCell" bundle:nil];
    [self.coursesTableView registerNib: nib forCellReuseIdentifier: @"CourseCell"];
    [Course getCourses:^(NSError * _Nonnull error, NSArray * _Nonnull courses) {
            if (error == nil) {
                self.coursesArray = courses;
                for (Course *c in courses) {
                    NSLog(@"%@", c.courseid);
                }
                [self.coursesTableView reloadData];
            }
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"CourseCell" forIndexPath:indexPath];
    Course *course = self.coursesArray[indexPath.row];
    cell.delegate = self;
    [cell configureCell: course];
    [cell.joinClassButton setHidden: FALSE];
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

@end
