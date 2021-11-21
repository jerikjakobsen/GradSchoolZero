//
//  VisitorStudentsViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "VisitorStudentsViewController.h"
#import "../Table View Cells/StudentCell.h"

@interface VisitorStudentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *studentsTableView;

@end

@implementation VisitorStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.studentsTableView.delegate = self;
    self.studentsTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"StudentCell" bundle:nil];
    [self.studentsTableView registerNib:nib forCellReuseIdentifier:@"StudentCell"];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StudentCell *cell = [self.studentsTableView dequeueReusableCellWithIdentifier: @"StudentCell"];
    [cell configureCell:@"John Jakobsen" gpa: @(3.8)];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


@end
