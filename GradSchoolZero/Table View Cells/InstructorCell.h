//
//  InstructorCell.h
//  GradSchoolZero
//
//  Created by Uzma Kapadia on 12/4/21.
//

#import <UIKit/UIKit.h>
#import "../Models/Instructor.h"

NS_ASSUME_NONNULL_BEGIN

@protocol InstructorCellDelegate

- (void) didReport: (Instructor *) instructor;

@end

@interface InstructorCell : UITableViewCell

@property (weak, nonatomic) id<InstructorCellDelegate> delegate;
@property (strong, nonatomic) Instructor *instructor;
@property (weak, nonatomic) IBOutlet UILabel *instructorName;
@property (weak, nonatomic) IBOutlet UILabel *instructorRating;

- (void) configureCell: (Instructor *) instructor;

@end

NS_ASSUME_NONNULL_END
