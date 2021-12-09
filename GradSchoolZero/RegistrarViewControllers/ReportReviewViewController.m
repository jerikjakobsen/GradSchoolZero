//
//  ReportReviewViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import "ReportReviewViewController.h"
#import "../Table View Cells/ReportReviewCell.h"
#import"../Models/User.h"

@interface ReportReviewViewController () <UITableViewDelegate, UITableViewDataSource, ReportReviewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *reportsTableView;
@property (strong, nonatomic) NSArray *reports;

@end

@implementation ReportReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reportsTableView.delegate = self;
    self.reportsTableView.dataSource = self;
    [User getReports:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull reports) {
        if (succeeded) {
            self.reports = reports;
            [self.reportsTableView reloadData];
        }
    }];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ReportReviewCell *cell = [self.reportsTableView dequeueReusableCellWithIdentifier:@"ReportReviewCell"];
    [cell configureCell:self.reports[indexPath.row]];
    cell.delegate = self;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reports.count;
}

- (void)action1:(nonnull NSString *)reportID {
    [User reviewReport:reportID decision:true completion:^(bool succeeded, NSError * _Nonnull error) {
        NSMutableArray *newArr = [[NSMutableArray alloc] init];
        for (NSDictionary *rep in self.reports) {
            if (![rep[@"id"] isEqualToString:reportID]) {
                [newArr addObject: rep];
            }
        }
        self.reports = newArr;
        [self.reportsTableView reloadData];
    }];
}

- (void)action2:(nonnull NSString *)reportID {
    [User reviewReport:reportID decision:false completion:^(bool succeeded, NSError * _Nonnull error) {
        NSMutableArray *newArr = [[NSMutableArray alloc] init];
        for (NSDictionary *rep in self.reports) {
            if (![rep[@"id"] isEqualToString:reportID]) {
                [newArr addObject: rep];
            }
        }
        self.reports = newArr;
        [self.reportsTableView reloadData];
    }];
}

@end
