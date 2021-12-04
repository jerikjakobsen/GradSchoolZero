//
//  StudentCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "StudentCell.h"

@implementation StudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (NSString *) name gpa: (NSNumber *) gpa {
    self.nameLabel.text = name;
    self.gpaLabel.text = [NSString stringWithFormat: @"GPA %@/4.0", gpa];
}

- (void) configureCell: (Student *) student {
    [self configureCell: student.name gpa: student.GPA];
}

@end
