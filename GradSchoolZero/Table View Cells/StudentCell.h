//
//  StudentCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import <UIKit/UIKit.h>
#import "../Models/Student.h"

NS_ASSUME_NONNULL_BEGIN

@protocol StudentCellDelegate

- (void) presentErrorMessage: (NSString *) message;
- (void) action1: (Student *) student completion: (void (^)(NSString *message, bool succeeded)) completion;
- (void) action2: (Student *) student completion: (void (^)(NSString *message, bool succeeded)) completion;

@end

@interface StudentCell : UITableViewCell

@property (weak, nonatomic) id<StudentCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;
@property (strong, nonatomic) Student *student;
@property (weak, nonatomic) IBOutlet UIButton *action1Button;
@property (weak, nonatomic) IBOutlet UIButton *action2Button;

- (void) configureCell: (Student *) student;
- (void) configureCell: (NSString *) name gpa: (NSNumber *) gpa;

@end

NS_ASSUME_NONNULL_END
