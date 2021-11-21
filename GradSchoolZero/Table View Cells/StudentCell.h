//
//  StudentCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/20/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;

- (void) configureCell: (NSString *) name gpa: (NSNumber *) gpa;

@end

NS_ASSUME_NONNULL_END
