//
//  InstructorCoursesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/5/21.
//

#import "InstructorCoursesViewController.h"
#import "../Table View Cells/CourseCell.h"
#import "../Models/Instructor.h"
#import "InstructorCourseStudentsViewController.h"

@interface InstructorCoursesViewController () <UITableViewDelegate, UITableViewDataSource, CourseCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSArray *courses;

@end

@implementation InstructorCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"CourseCell" bundle:nil];
    [self.coursesTableView registerNib: nib forCellReuseIdentifier: @"CourseCell"];
    [[Instructor sharedInstructor] getAllInstructorCourses:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull courses) {
        NSMutableArray *activeCourses = [[NSMutableArray alloc] init];
        NSLog(@"%@", courses);
        if (succeeded) {
            for (Course *c in courses) {
                if ([c isActive]) {
                    [activeCourses addObject: c];
                }
            }
            self.courses = activeCourses;
            [self.coursesTableView reloadData];
        }
    }];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"CourseCell"];
    cell.actionButton.hidden = TRUE;
    Course *c = self.courses[indexPath.row];
    [cell configureCell: c];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (void)buttonAction:(nonnull NSString *)courseID completion:(nonnull void (^)(NSString * _Nonnull, bool))completion {
    
}

- (nonnull NSString *)buttonMessage {
    return @"Empty";
}

- (void)presentErrorMessage:(nonnull NSString *)message {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    InstructorCourseStudentsViewController *vc = segue.destinationViewController;
    vc.course = (Course *) sender;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier: @"courseToStudents" sender: self.courses[indexPath.row]];
}

@end
