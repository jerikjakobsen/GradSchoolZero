//
//  StudentCell.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import "StudentCell.h"
#import "../Models/User.h"

@implementation StudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.action2Button.hidden = TRUE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCell: (NSString *) name gpa: (NSNumber *) gpa {
    self.nameLabel.text = name;
    self.gpaLabel.text = [NSString stringWithFormat: @"GPA %.2f/4.0", gpa.floatValue];
}

- (void) configureCell: (Student *) student {
    self.student = student;
    [self configureCell: student.name gpa: student.GPA];

}
- (IBAction)didTapAction1:(id)sender {
    [self.delegate action1: self.student.userID completion:^(NSString * _Nonnull message, bool succeeded) {
            if (succeeded) {
                [self.delegate presentErrorMessage:@"Report Successful"];
            }
    }];
}

- (IBAction)didTapAction2:(id)sender {
    NSLog(@"ACTION 2 before");
    [self.delegate action2: self.student.userID completion:^(NSString * _Nonnull message, bool succeeded) {
        NSLog(@"ACTION 2");
    }];
}


@end
