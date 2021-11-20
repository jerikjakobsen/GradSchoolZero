//
//  CourseCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *professorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinClassButton;
@property (strong, nonatomic) NSString *courseID;

- (void) configureCell: (NSString *) name professor: (NSString *) profName studentCount: (NSInteger *) count capacityCount: (NSInteger *) capacityCount courseID: (NSString *) courseID;

@end

NS_ASSUME_NONNULL_END
