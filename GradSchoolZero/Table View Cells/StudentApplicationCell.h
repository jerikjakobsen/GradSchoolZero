//
//  StudentApplicationCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StudentApplicationCellDelegate

- (void) studentAction1: (NSString *) appID;
- (void) studentAction2: (NSString *) appID;

@end

@interface StudentApplicationCell : UITableViewCell

@property (weak, nonatomic) id<StudentApplicationCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;
@property (weak, nonatomic) IBOutlet UILabel *programLabel;
@property (weak, nonatomic) IBOutlet UILabel *graduationYearLabel;
@property (strong, nonatomic) NSString *appID;

- (void) configureCell: (NSDictionary * ) app;

@end

NS_ASSUME_NONNULL_END
