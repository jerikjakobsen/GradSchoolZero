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

- (IBAction)didTapJoinClass:(id)sender {
    [[Student sharedStudent] joinClass: self.courseID completion:^(bool succeeded, NSError * _Nonnull error, NSString * _Nonnull message) {
        if (succeeded) {
            self.joinClassButton.titleLabel.text = @"Enrolled";
            self.joinClassButton.enabled = FALSE;
            self.course.studentCount = @([self.course.studentCount intValue] + 1);
            self.studentCountLabel.text = [NSString stringWithFormat: @"%@/%@ Capacity", self.course.studentCount, self.course.capacity];

        } else {
            [self.delegate presentErrorMessage: message];
        }
    }];
}

@end
