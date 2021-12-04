//
//  ClassCell.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/4/21.
//

#import <UIKit/UIKit.h>
#import "../Models/Course.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *professorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *semesterLabel;

- (void) configureCell: (Course *) course classInfo: (NSDictionary *) classInfo;

@end

NS_ASSUME_NONNULL_END
