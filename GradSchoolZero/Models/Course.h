//
//  Course.h
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * courseid;
@property (nonatomic, strong) NSNumber * capacity;
@property (nonatomic, strong) NSNumber * studentCount;
@property (nonatomic, strong) NSString * instructorid;
@property (nonatomic, strong) NSString * instructorName;
@property (nonatomic, strong) NSArray  * days;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * endTime;

- (void) setActive: (bool) active;
- (bool) isActive;

- (bool) isEqualCourse: (Course *) course;

+ (void) getCourses: (void (^)(NSError * error, NSArray* courses)) completion;

- (instancetype) initWithName: (NSString *) name courseID: (NSString *) courseID capacity: (NSString *) capacity studentCount: (NSString *) studentCount instructorid: (NSString *) instructorid instructorName: (NSString *) instructorName days: (NSString *) days startTime: (NSString *) startTime endTime: (NSString *) endTime active: (bool) active;

- (instancetype) initWithJSON: (NSDictionary *) json;

- (NSString *) getTimeDate;

@end

NS_ASSUME_NONNULL_END
