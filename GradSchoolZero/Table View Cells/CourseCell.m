//
//  CourseCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/19/21.
//

#import "CourseCell.h"
#import "../Models/Student.h"

@implementation CourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (NSString *) name professor: (NSString *) profName studentCount: (NSNumber *) studentCount capacityCount: (NSNumber *) capacityCount courseID: (NSString *) courseID time: (NSString *) time {
    self.actionButton.titleLabel.text = [self.delegate buttonMessage];
    self.nameLabel.text = name;
    self.professorNameLabel.text = profName;
    self.studentCountLabel.text = [NSString stringWithFormat: @"%@/%@ Capacity", studentCount, capacityCount];
    self.courseID = courseID;
    self.timeLabel.text = time;
}

- (void) configureCell: (Course *) course {
    [self configureCell:course.name professor:course.instructorName studentCount:course.studentCount capacityCount:course.capacity courseID:course.courseid time: [course getTimeDate]];
    self.course = course;
}

- (IBAction)didTapButton:(id)sender {
    
    [self.delegate buttonAction: self.courseID completion:^(NSString * _Nonnull message, bool succeeded) {
        if (succeeded) {
            self.actionButton.enabled = FALSE;
            if ([[self.delegate buttonMessage] isEqualToString: @"Drop"]) {
                self.course.studentCount = @([self.course.studentCount intValue] - 1);
                self.studentCountLabel.text = [NSString stringWithFormat: @"%@/%@ Capacity", self.course.studentCount, self.course.capacity];
            } else {
                self.course.studentCount = @([self.course.studentCount intValue] + 1);
                self.studentCountLabel.text = [NSString stringWithFormat: @"%@/%@ Capacity", self.course.studentCount, self.course.capacity];
            }

        } else {
            [self.delegate presentErrorMessage: message];
        }
    }];
}

@end
