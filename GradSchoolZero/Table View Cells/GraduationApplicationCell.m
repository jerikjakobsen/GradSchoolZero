//
//  GraduationApplicationCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import "GraduationApplicationCell.h"

@implementation GraduationApplicationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (Student *) student appID: (NSString *) appID {
    self.nameLabel.text = student.name;
    self.currentGPALabel.text = [NSString stringWithFormat: @"%@", student.GPA];
}

- (IBAction)acceptApplication:(id)sender {
    [self.delegate graduationAction1: self.appID];
}

- (IBAction)denyApplication:(id)sender {
    [self.delegate graduationAction2: self.appID];
}

@end
