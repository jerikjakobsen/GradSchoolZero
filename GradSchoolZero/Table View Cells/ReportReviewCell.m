//
//  ReportReviewCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import "ReportReviewCell.h"

@implementation ReportReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void) configureCell: (NSDictionary *) dict {
    
    self.complainerNameLabel.text = [NSString stringWithFormat: @"Reporter Name: %@", dict[@"reportername"]];
    self.complainerTypeLabel.text = dict[@"reportertype"];
    self.complaineeNameLabel.text =  [NSString stringWithFormat: @"Reporter Nanme: %@", dict[@"reportedname"]];
    self.complaineeTypeLabel.text = dict[@"reportedtype"];
    self.complaintLabel.text = [NSString stringWithFormat: @"Written Report: %@", dict[@"writtenreport"]];
    self.reportid = dict[@"id"];

}

- (IBAction)giveWarning:(id)sender {
    [self.delegate action1: self.reportid];
}

- (IBAction)deleteComplaint:(id)sender {
    [self.delegate action2: self.reportid];
}

@end
