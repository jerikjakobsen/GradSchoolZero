//
//  ReportReviewCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReportReviewCellDelegate

- (void) action1: (NSString *) reportID;

- (void) action2: (NSString *) reportID;

@end

@interface ReportReviewCell : UITableViewCell

@property (weak, nonatomic) id<ReportReviewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *complainerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *complainerTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *complaineeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *complaineeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *complaintLabel;
@property (strong, nonatomic) NSString *reportid;

- (void) configureCell: (NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
