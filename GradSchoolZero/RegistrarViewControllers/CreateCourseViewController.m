//
//  CreateCourseViewController.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 12/9/21.
//

#import "CreateCourseViewController.h"
#import "../Models/Instructor.h"
#import "../Models/User.h"

@interface CreateCourseViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *instructorsPickerView;
@property (weak, nonatomic) IBOutlet UITextField *courseNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *courseCapacityTextField;
@property (weak, nonatomic) IBOutlet UISwitch *monSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *tuesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *wedSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *thursSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *friSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sattSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sunSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTimePicker;
@property (strong, nonatomic) NSArray *instructors;
@property (strong, nonatomic) Instructor *selectedInstructor;
@property (strong, nonatomic) NSMutableArray *days;

@end

@implementation CreateCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.days = [[NSMutableArray alloc] initWithArray:@[@0, @0, @0, @0, @0, @0, @0]];
    self.instructorsPickerView.delegate = self;
    self.instructorsPickerView.dataSource = self;
    [Instructor getAllInstructors:^(bool succeeded, NSError * _Nonnull error, NSArray * _Nonnull instructors) {
        if (succeeded) {
            self.instructors = instructors;
            [self.instructorsPickerView reloadAllComponents];
        }
    }];

}

- (IBAction)didTapCreateCourse:(id)sender {
    // Checks
    if ([self.endTimePicker.date timeIntervalSinceDate: self.startTimePicker.date] < 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Error" message:@"End Time must be after Start Time" preferredStyle: UIAlertControllerStyleAlert ];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction: action];
        [self presentViewController:alert animated:YES completion: nil];
        return;
    } else
    if (self.courseNameTextField.text.length == 0 || self.courseCapacityTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Error" message:@"All Fields must be filled" preferredStyle: UIAlertControllerStyleAlert ];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction: action];
        [self presentViewController:alert animated:YES completion: nil];
        return;
    }
    bool oneday = false;
    for (NSNumber *n in self.days) {
        if ([n isEqualToNumber: @1]) {
            oneday = true;
            break;
        }
    }
    if (!oneday) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Error" message:@"Select at least one day" preferredStyle: UIAlertControllerStyleAlert ];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction: action];
        [self presentViewController:alert animated:YES completion: nil];
        return;
    }
    NSMutableString *dayss = [[NSMutableString alloc] init];
    for (int i = 0; i < self.days.count; i++) {
        if ([self.days[i] isEqualToNumber: @1]) {
            [dayss appendString:[NSString stringWithFormat: @"%d", i] ];
        }
    }
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger stH = [cal component:NSCalendarUnitHour fromDate:self.startTimePicker.date];
    NSInteger stM = [cal component:NSCalendarUnitMinute fromDate:self.startTimePicker.date];
    NSInteger etH = [cal component:NSCalendarUnitHour fromDate:self.endTimePicker.date];
    NSInteger etM = [cal component:NSCalendarUnitMinute fromDate:self.endTimePicker.date];
    
    NSString *st = [NSString stringWithFormat: @"%@%@", [self getTimeForBackend: stH],  [self getTimeForBackend: stM]];
    NSString *et = [NSString stringWithFormat: @"%@%@", [self getTimeForBackend: etH],  [self getTimeForBackend: etM]];
    [User createCourse:self.selectedInstructor.userID name:self.courseNameTextField.text cap:self.courseCapacityTextField.text days: dayss startTime:st endTime:et completion:^(bool succeeded, NSError * _Nonnull error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"Error" message:@"Something Went Wrong" preferredStyle: UIAlertControllerStyleAlert ];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction: action];
            [self presentViewController:alert animated:YES completion: nil];
        }
    }];
}



- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.instructors.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return ((Instructor *) self.instructors[row]).name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedInstructor = self.instructors[row];
    NSLog(@"%@", self.selectedInstructor.name);
}

- (IBAction)didChangeMon:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.monSwitch.isOn];
    self.days[1] = num;
}
- (IBAction)didChangeTues:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.tuesSwitch.isOn];
    self.days[2] = num;
}
- (IBAction)didChangeWed:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.wedSwitch.isOn];
    self.days[3] = num;
}
- (IBAction)didChangeThurs:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.thursSwitch.isOn];
    self.days[4] = num;
}
- (IBAction)didChangeFri:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.friSwitch.isOn];
    self.days[5] = num;
}
- (IBAction)didChangeSat:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.sattSwitch.isOn];
    self.days[6] = num;
}
- (IBAction)didChangeSun:(id)sender {
    NSNumber *num = [NSNumber numberWithBool:self.sunSwitch.isOn];
    self.days[0] = num;
}

- (NSString *) getTimeForBackend: (NSInteger) time {
    if (time < 10) return [NSString stringWithFormat: @"0%ld", time];
    return [NSString stringWithFormat: @"%ld", time];
}

@end
