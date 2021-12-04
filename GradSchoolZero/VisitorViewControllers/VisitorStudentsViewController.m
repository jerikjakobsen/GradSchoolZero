//
//  VisitorStudentsViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "VisitorStudentsViewController.h"
#import "../Table View Cells/StudentCell.h"
#import "../Models/Student.h"

@interface VisitorStudentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *studentsTableView;
@property (strong, nonatomic) NSArray *studentArray;

@end

@implementation VisitorStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentsTableView.delegate = self;
    self.studentsTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"StudentCell" bundle:nil];
    [self.studentsTableView registerNib:nib forCellReuseIdentifier:@"StudentCell"];
    [Student getAllStudents:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull json) {
        self.studentArray = json;
        [self.studentsTableView reloadData];
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StudentCell *cell = [self.studentsTableView dequeueReusableCellWithIdentifier: @"StudentCell"];
    Student *student = self.studentArray[indexPath.row];
    [cell configureCell: student.name gpa: student.GPA];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentArray.count;
}


@end
