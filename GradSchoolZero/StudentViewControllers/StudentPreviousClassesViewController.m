//
//  StudentPreviousClassesViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/4/21.
//

#import "StudentPreviousClassesViewController.h"
#import "../Models/Student.h"
#import "../Table View Cells/ClassCell.h"

@interface StudentPreviousClassesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;
@property (strong, nonatomic) NSDictionary *courses;

@end

@implementation StudentPreviousClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    [[Student sharedStudent] getCompletedClasses:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull json) {
        if (succeeded) {
            self.courses = json;
            [self.coursesTableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ClassCell *cell = [self.coursesTableView dequeueReusableCellWithIdentifier: @"ClassCell"];
    NSDictionary *class = self.courses[@"classes"][indexPath.row];
    Course *course = self.courses[@"courses"][indexPath.row];
    [cell configureCell:course classInfo:class];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *) self.courses[@"courses"]).count;
}

@end
