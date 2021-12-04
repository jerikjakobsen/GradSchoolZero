//
//  ClassCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/4/21.
//

#import "ClassCell.h"

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (Course *) course classInfo: (NSDictionary *) classInfo {
    self.courseNameLabel.text = course.name;
    self.professorNameLabel.text = course.instructorName;
    self.gradeLabel.text = classInfo[@"grade"];
    NSString *season = classInfo[@"season"];
    NSNumber *year = classInfo[@"year"];
    self.semesterLabel.text = [NSString stringWithFormat: @"%@ %@", season, year];
}

@end
