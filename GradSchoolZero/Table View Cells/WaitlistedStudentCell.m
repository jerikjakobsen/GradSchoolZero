//
//  WaitlistedStudentCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/5/21.
//

#import "WaitlistedStudentCell.h"
#import "../Models/Instructor.h"

@implementation WaitlistedStudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureCell: (Student *) student course: (Course *) course {
    self.course = course;
    self.student = student;
    
    self.courseNameLabel.text = course.name;
    self.studentNameLabel.text = student.name;
}
- (IBAction)didAcceptStudent:(id)sender {
    [[Instructor sharedInstructor] reviewWaitlistedStudents: true courseid:self.course.courseid studentid:self.student.userID completion:^(bool succeeded, NSError * _Nonnull error, NSString * _Nonnull message) {
        if (succeeded) {
            [self.delegate didReviewStudent: succeeded course: self.course student: self.student];
        }
    }];
}
- (IBAction)didDenyStudent:(id)sender {
    [[Instructor sharedInstructor] reviewWaitlistedStudents: false courseid:self.course.courseid studentid:self.student.userID completion:^(bool succeeded, NSError * _Nonnull error, NSString * _Nonnull message) {
        if (succeeded) {
            [self.delegate didReviewStudent: succeeded course: self.course student: self.student];
        }
    }];
}

@end
