//
//  VisitorCoursesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "VisitorCoursesViewController.h"
#import "../Table View Cells/CourseCell.h"
#import "../Models/User.h"
#import "../Models/Course.h"

@interface VisitorCoursesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSArray *coursesArray;

@end

@implementation VisitorCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"CourseCell" bundle:nil];
    [self.coursesTableView registerNib: nib forCellReuseIdentifier: @"CourseCell"];
    [Course getCourses:^(NSError * _Nonnull error, NSArray * _Nonnull courses) {
            if (error == nil) {
                self.coursesArray = courses;
                [self.coursesTableView reloadData];
            }
    }];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"CourseCell" forIndexPath:indexPath];
    Course *course = self.coursesArray[indexPath.row];
    
    [cell configureCell: course.name professor:course.instructorName studentCount: course.studentCount capacityCount: course.capacity courseID: course.courseid time: [course getTimeDate]];
    [cell.joinClassButton setHidden: TRUE];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.coursesArray.count;
}

@end
