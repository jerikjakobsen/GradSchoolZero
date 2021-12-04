//
//  CourseCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/19/21.
//

#import <UIKit/UIKit.h>
#import "../Models/Course.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CourseCellDelegate

- (void) presentErrorMessage: (NSString *) message;
- (NSString *) buttonMessage;
- (void) buttonAction: (NSString *) courseID completion: (void (^)(NSString *message, bool succeeded)) completion;

@end

@interface CourseCell : UITableViewCell

@property (weak, nonatomic) id<CourseCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *professorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) NSString *courseID;
@property (strong, nonatomic) Course *course;

- (void) configureCell: (NSString *) name professor: (NSString *) profName studentCount: (NSNumber *) count capacityCount: (NSNumber *) capacityCount courseID: (NSString *) courseID time: (NSString *) time;
- (void) configureCell: (Course *) course;

@end

NS_ASSUME_NONNULL_END
