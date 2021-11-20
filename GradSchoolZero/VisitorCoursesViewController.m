//
//  VisitorCoursesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "VisitorCoursesViewController.h"
#import "Table View Cells/CourseCell.h"

@interface VisitorCoursesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;

@end

@implementation VisitorCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName: @"CourseCell" bundle:nil];
    [self.coursesTableView registerNib: nib forCellReuseIdentifier: @"CourseCell"];
    [self.coursesTableView reloadData];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CourseCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"CourseCell" forIndexPath:indexPath];
    [cell configureCell:@"Programming Language Paradigms" professor:@"Douglas Troeger" studentCount:@(20) capacityCount:@(30) courseID:@"12343412"];
    [cell.joinClassButton setHidden: TRUE];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

@end
