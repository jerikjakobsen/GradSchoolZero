//
//  StudentApplicationCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/8/21.
//

#import "StudentApplicationCell.h"

@implementation StudentApplicationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (NSDictionary * ) app {
    NSString *name = [NSString stringWithFormat: @"%@ %@", app[@"firstname"], app[@"lastname"] ];
    self.nameLabel.text = name;
    self.gpaLabel.text = [NSString stringWithFormat: @"%@", app[@"gpa"]];
    self.programLabel.text = app[@"program"];
    self.graduationYearLabel.text = [NSString stringWithFormat: @"%@", app[@"graduationyear"]];
    self.appID = app[@"id"];
}

- (IBAction)acceptApplication:(id)sender {
    [self.delegate studentAction1: self.appID];
}
- (IBAction)denyApplication:(id)sender {
    [self.delegate studentAction2: self.appID];
}

@end
