//
//  Course.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/1/21.
//

#import "Course.h"
#import "../APIManager.h"

@implementation Course

bool _active = FALSE;

- (bool) isEqualCourse: (Course *) course {
    return [self.courseid isEqualToString: course.courseid];
}

+ (void) getCourses: (void (^)(NSError * error, NSArray* courses)) completion {
    
    [APIManager GET:@"courses" parameters:@{} completion:^(bool succeeded, NSError * _Nonnull error, NSDictionary * _Nonnull data, NSInteger code) {
            NSMutableArray *courses = [[NSMutableArray alloc] init];
            if (error!= nil) {
                NSLog(@"%@", error.localizedDescription);
            }
            for (NSDictionary *course in data) {
                Course *c = [[Course alloc] initWithJSON: course];
                [courses addObject: c];
            }
            completion(error, courses);
    }];
}

- (void) setActive: (bool) active {
    _active = active;
}
- (bool) isActive {
    return _active;
}

- (instancetype) initWithName: (NSString *) name courseID: (NSString *) courseID capacity: (NSString *) capacity studentCount: (NSString *) studentCount instructorid: (NSString *) instructorid instructorName: (NSString *) instructorName days: (NSString *) days startTime: (NSString *) startTime endTime: (NSString *) endTime active: (bool) active; {
    if (self = [super init]) {
        [self setActive: active];
        self.name = name;
        self.courseid = courseID;
        self.capacity = @([capacity intValue]);
        self.studentCount = @([studentCount intValue]);
        self.instructorid = instructorid;
        NSArray *dayArray = @[@"Sun", @"Mon", @"Tues", @"Wed", @"Thurs", @"Fri", @"Sat"];
        self.days = [[NSArray alloc] init];
        for (int i = 0; i < days.length; i++) {
            int dayIndex = [[days substringWithRange: NSMakeRange(i, 1)] intValue];
            self.days = [self.days arrayByAddingObject: dayArray[dayIndex]];
        }
        
        self.startTime = [NSString stringWithFormat: @"%@:%@", [self properTimeString: [startTime substringToIndex: 2]], [self properTimeString: [startTime substringFromIndex: 2]]];
        self.endTime = [NSString stringWithFormat: @"%@:%@", [self properTimeString: [endTime substringToIndex: 2]], [self properTimeString: [endTime substringFromIndex: 2]]];
        self.instructorName = instructorName;
    }
    return self;
}

- (NSString *) properTimeString: (NSString *) time {
    if ([time intValue] == 0) return @"00";
    else return [NSString stringWithFormat: @"%d", [time intValue]];
}

- (instancetype) initWithJSON: (NSDictionary *) json {
    if (self = [super init]) {
        self = [self initWithName:json[@"name"] courseID:json[@"id"] capacity:json[@"capacity"] studentCount:json[@"studentcount"] instructorid:json[@"instructorid"] instructorName: json[@"instructorname"] days:json[@"days"] startTime:json[@"starttime"] endTime:json[@"endtime"] active: json[@"active"]];
    }
    return self;
}

- (NSString *) getTimeDate {
    NSString * dayString = [[NSString alloc] init];
    for (int i = 0; i < self.days.count; i++) {
        dayString = [dayString stringByAppendingString: @" "];
        dayString = [dayString stringByAppendingString: (NSString *) self.days[i]];
    }
    return [NSString stringWithFormat:@"%@\n %@ - %@", dayString, self.startTime, self.endTime ];
}


@end
