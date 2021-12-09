//
//  InstructorCell.m
//  GradSchoolZero
//
//  Created by Uzma Kapadia on 12/4/21.
//

#import "InstructorCell.h"

@implementation InstructorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (Instructor *) instructor {
    self.instructor = instructor;
    self.instructorName.text = instructor.name;
    
}
- (IBAction)didTapReport:(id)sender {
    [self.delegate didTapAction1: self.instructor];
}

@end
