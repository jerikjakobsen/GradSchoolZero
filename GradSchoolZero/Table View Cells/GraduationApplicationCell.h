//
//  GraduationApplicationCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import <UIKit/UIKit.h>
#import "../Models/Student.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GraduationApplicationCellDelegate

- (void) graduationAction1: (NSString *) appID;

- (void) graduationAction2: (NSString *) appID;

@end

@interface GraduationApplicationCell : UITableViewCell

@property (weak, nonatomic) id<GraduationApplicationCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentGPALabel;
@property (strong, nonatomic) NSString *appID;
@property (strong, nonatomic) Student *student;

- (void) configureCell: (Student *) student appID: (NSString *) appID;

@end

NS_ASSUME_NONNULL_END
