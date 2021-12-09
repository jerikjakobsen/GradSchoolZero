//
//  InstructorApplicationCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InstructorApplicationCellDelegate

- (void) instructorAction1: (NSString *) appID;
- (void) instructorAction2: (NSString *) appID;

@end

@interface InstructorApplicationCell : UITableViewCell

@property (weak, nonatomic) id<InstructorApplicationCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *programLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearsOfExperienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *graduationYearLabel;
@property (strong, nonatomic) NSString *appID;

- (void) configureCell: (NSDictionary *) appDict;

@end

NS_ASSUME_NONNULL_END
