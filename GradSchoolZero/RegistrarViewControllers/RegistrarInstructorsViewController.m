//
//  RegistrarInstructorsViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/8/21.
//

#import "RegistrarInstructorsViewController.h"
#import "../Table View Cells/InstructorCell.h"
#import "../Models/Instructor.h"

@interface RegistrarInstructorsViewController () <UITableViewDelegate, UITableViewDataSource, InstructorCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *instructorsTableView;
@property (strong, nonatomic) NSArray *instructors;

@end

@implementation RegistrarInstructorsViewController

- (void)viewDidAppear:(BOOL)animated {
    [self.instructorsTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName: @"InstructorCell" bundle:nil];
    [self.instructorsTableView registerNib: nib forCellReuseIdentifier:@"InstructorCell"];
    self.instructorsTableView.delegate = self;
    self.instructorsTableView.dataSource = self;
    [Instructor getAllInstructors:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull instructors) {
        if (succeeded) {
            self.instructors = instructors;
            [self.instructorsTableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstructorCell *cell = [self.instructorsTableView dequeueReusableCellWithIdentifier:@"InstructorCell" forIndexPath:indexPath];
    Instructor *ins = self.instructors[indexPath.row];
    [cell configureCell: ins];
    cell.delegate = self;
    [cell.action1Button setHidden: TRUE];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.instructors.count;
}

- (void)didTapAction1:(nonnull Instructor *)instructor {
    // Change to Fire
}

@end
