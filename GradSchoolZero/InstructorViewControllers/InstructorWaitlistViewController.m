//
//  InstructorWaitlistViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/5/21.
//

#import "InstructorWaitlistViewController.h"
#import "../Table View Cells/WaitlistedStudentCell.h"
#import "../Models/Instructor.h"
#import "../Models/Course.h"
#import "../Models/Student.h"

@interface InstructorWaitlistViewController () <WaitlistedCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *waitlistedStudentsTableView;
@property (strong, nonatomic) NSArray *studentCourses;

@end

@implementation InstructorWaitlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waitlistedStudentsTableView.delegate = self;
    self.waitlistedStudentsTableView.dataSource = self;
    [[Instructor sharedInstructor] getWaitlistedStudents:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull data) {
        if (succeeded) {
            self.studentCourses = data;
            [self.waitlistedStudentsTableView reloadData];
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReviewStudent:(bool)succeeded course: (Course *) course student: (Student *) student {
    if (succeeded) {
        NSMutableArray *newStudentCourses = [[NSMutableArray alloc] init];
        for (NSDictionary *sc in self.studentCourses) {
            Course *c = sc[@"course"];
            Student *s = sc[@"student"];
            if (!([c isEqualCourse:course] && [s isEqualStudent: student])) {
                [newStudentCourses addObject: @{@"course": c, @"student": s}];
            }
        }
        self.studentCourses = newStudentCourses;
        [self.waitlistedStudentsTableView reloadData];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WaitlistedStudentCell *cell = [self.waitlistedStudentsTableView dequeueReusableCellWithIdentifier: @"WaitlistedStudentCell"];
    Course *c = self.studentCourses[indexPath.row][@"course"];
    Student *s = self.studentCourses[indexPath.row][@"student"];
    [cell configureCell:s course:c];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentCourses.count;
}

@end
