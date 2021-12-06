//
//  WaitlistedStudentCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/5/21.
//

#import <UIKit/UIKit.h>
#import "../Models/Course.h"
#import "../Models/Student.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WaitlistedCellDelegate

- (void) didReviewStudent: (bool) succeeded course: (Course *) course student: (Student *) student;

@end

@interface WaitlistedStudentCell : UITableViewCell

@property (nonatomic, strong) Student *student;
@property (nonatomic, strong) Course *course;
@property (weak, nonatomic) id<WaitlistedCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;

-(void) configureCell: (Student *) student course: (Course *) course;

@end

NS_ASSUME_NONNULL_END
