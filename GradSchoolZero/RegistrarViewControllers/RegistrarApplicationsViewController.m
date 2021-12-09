//
//  RegistrarApplicationsViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/8/21.
//

#import "RegistrarApplicationsViewController.h"
#import "../Table View Cells/InstructorApplicationCell.h"
#import "../Table View Cells/StudentApplicationCell.h"
#import "../Table View Cells/GraduationApplicationCell.h"
#import "../Models/User.h"

@interface RegistrarApplicationsViewController () <UITableViewDelegate, UITableViewDataSource, InstructorApplicationCellDelegate, StudentApplicationCellDelegate, GraduationApplicationCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *applicationsTableView;
@property (strong, nonatomic) NSArray *studentApps;
@property (strong, nonatomic) NSArray *instructorApps;
@property (strong, nonatomic) NSArray *graduationApps;


@end

@implementation RegistrarApplicationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.applicationsTableView.delegate = self;
    self.applicationsTableView.dataSource = self;
    [User getStudentApplications:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull applications) {
        if (succeeded) {
            self.studentApps = applications;
            [self.applicationsTableView reloadData];
        }
    }];
    
    [User getInstructorApplications:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull applications) {
        if (succeeded) {
            self.instructorApps = applications;
            [self.applicationsTableView reloadData];
        }
    }];
    
    [User getGraduationApplications:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull applications) {
        self.graduationApps = applications;
        [self.applicationsTableView reloadData];
    }];
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        StudentApplicationCell *cell = [self.applicationsTableView dequeueReusableCellWithIdentifier: @"StudentApplicationCell"];
        [cell configureCell: self.studentApps[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 1) {
        InstructorApplicationCell *cell = [self.applicationsTableView dequeueReusableCellWithIdentifier:@"InstructorApplicationCell"];
        [cell configureCell: self.instructorApps[indexPath.row]];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 2) {
        GraduationApplicationCell *cell = [self.applicationsTableView dequeueReusableCellWithIdentifier: @"GraduationApplicationCell"];
        NSDictionary *dict = self.graduationApps[indexPath.row];
        [cell configureCell:dict[@"student"] appID:dict[@"appID"]];
        cell.delegate = self;
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return self.studentApps.count;
    if (section == 1) return self.instructorApps.count;
    return self.graduationApps.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Student Applications";
    if (section == 1) return @"Instructor Applications";
    if (section == 2) return @"Graduation Applications";
    return @"";
}




- (void)instructorAction1:(nonnull NSString *)appID {
    [User reviewInstructorApplication:appID decision:true completion:^(bool succeeded, NSError * _Nonnull error) {
        if (succeeded) {
            NSMutableArray *newinstructorApps = [[NSMutableArray alloc] init];
            for (NSDictionary *d in self.instructorApps) {
                if (![d[@"id"] isEqualToString: appID]) {
                    [newinstructorApps addObject: d];
                }
            }
            self.instructorApps = newinstructorApps;
            [self.applicationsTableView reloadData];
        }
    }];
}

- (void)instructorAction2:(nonnull NSString *)appID {
    [User reviewInstructorApplication:appID decision:false completion:^(bool succeeded, NSError * _Nonnull error) {
        if (succeeded) {
            NSMutableArray *newinstructorApps = [[NSMutableArray alloc] init];
            for (NSDictionary *d in self.instructorApps) {
                if (![d[@"id"] isEqualToString: appID]) {
                    [newinstructorApps addObject: d];
                }
            }
            self.instructorApps = newinstructorApps;
            [self.applicationsTableView reloadData];
        }
    }];
}

- (void)studentAction1:(nonnull NSString *)appID {
    [User reviewStudentApplication:appID decision:true completion:^(bool succeeded, NSError * _Nonnull error) {
        NSMutableArray *newStudentApps = [[NSMutableArray alloc] init];
        for (NSDictionary *s in self.studentApps) {
            if (![s[@"id"] isEqualToString: appID]) {
                [newStudentApps addObject: s];
            }
        }
        self.studentApps = newStudentApps;
        [self.applicationsTableView reloadData];
    }];
}

- (void)studentAction2:(nonnull NSString *)appID {
    [User reviewStudentApplication:appID decision:false completion:^(bool succeeded, NSError * _Nonnull error) {
        NSMutableArray *newStudentApps = [[NSMutableArray alloc] init];
        for (NSDictionary *s in self.studentApps) {
            if (![s[@"id"] isEqualToString: appID]) {
                [newStudentApps addObject: s];
            }
        }
        self.studentApps = newStudentApps;
        [self.applicationsTableView reloadData];
    }];
}

- (void)graduationAction1:(nonnull NSString *)appID {
    [User reviewGraduationApplication:appID decision:true completion:^(bool succeeded, NSError * _Nonnull error) {
        NSMutableArray *newGradApps = [[NSMutableArray alloc] init];
        for (NSDictionary *s in self.studentApps) {
            if (![s[@"appID"] isEqualToString: appID]) {
                [newGradApps addObject: s];
            }
        }
        self.studentApps = newGradApps;
        [self.applicationsTableView reloadData];
    }];
}

- (void)graduationAction2:(nonnull NSString *)appID {
    [User reviewGraduationApplication:appID decision:false completion:^(bool succeeded, NSError * _Nonnull error) {
        NSMutableArray *newGradApps = [[NSMutableArray alloc] init];
        for (NSDictionary *s in self.studentApps) {
            if (![s[@"appID"] isEqualToString: appID]) {
                [newGradApps addObject: s];
            }
        }
        self.studentApps = newGradApps;
        [self.applicationsTableView reloadData];
    }];
}

@end
