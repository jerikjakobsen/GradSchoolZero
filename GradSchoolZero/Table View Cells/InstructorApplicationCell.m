//
//  InstructorApplicationCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/8/21.
//

#import "InstructorApplicationCell.h"

@implementation InstructorApplicationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (NSDictionary *) appDict {
    NSString *name = [NSString stringWithFormat: @"%@ %@", appDict[@"firstname"], appDict[@"lastname"] ];
    self.nameLabel.text = name;
    self.yearsOfExperienceLabel.text = [NSString stringWithFormat: @"%@", appDict[@"yearsofexperience"]];
    self.programLabel.text = appDict[@"program"];
    self.graduationYearLabel.text = [NSString stringWithFormat: @"%@", appDict[@"graduationyear"]];
    self.appID = appDict[@"id"];
}
- (IBAction)acceptApplication:(id)sender {
    [self.delegate instructorAction1: self.appID];
    
}
- (IBAction)denyApplication:(id)sender {
    [self.delegate instructorAction2: self.appID];
}

@end
