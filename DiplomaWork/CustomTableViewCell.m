//
//  CustomTableViewCell.m
//  DiplomaWork
//
//  Created by Meri on 12/5/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *xLable;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *yLable;
@property (weak, nonatomic) IBOutlet UITextField *valueTextFieldY;

@property(strong, nonatomic)NSString *key;
@property(strong, nonatomic)NSString *key1;



@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    //bolor@ tver chen
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self.valueTextField setText: @""];
        [self.valueTextFieldY setText: @""];
        return YES;
    }
    NSLog(@"x = %@", self.valueTextField.text);
    NSLog(@"y = %@", self.valueTextFieldY.text);
    [self.stacox saveValue:self.valueTextField.text keyX:self.key saveValue:self.valueTextFieldY.text   keyY:self.key1];
    return YES;
}

-(void)updateCell:(NSInteger) row xValue:(NSString *)xvalue yValue:(NSString *)yValue {
    [self.valueTextField setText: xvalue];
    [self.valueTextFieldY setText: yValue];
    self.key = [NSString stringWithFormat:@"X%ld", (long)row];
    self.key1 = [NSString stringWithFormat:@"Y%ld", (long)row];
//    
//    NSLog(@"key = %@", self.key);
//    NSLog(@"key1 = %@", self.key1);
    
    [self.xLable setText: [self.key stringByAppendingString: @" ="]];
    [self.yLable setText: [self.key1 stringByAppendingString: @" ="]];
}

@end
