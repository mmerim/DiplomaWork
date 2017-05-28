//
//  CustomIntegralTableViewCell.m
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "CustomIntegralTableViewCell.h"

@interface CustomIntegralTableViewCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *yLable;
@property (weak, nonatomic) IBOutlet UITextField *yValueTextField;

@property(strong, nonatomic)NSString *key;

@end


@implementation CustomIntegralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    //bolor@ tver chen
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self.yValueTextField setText: @""];
        return YES;
    }
    [self.stacox saveValue:self.yValueTextField.text keyY:self.key];
    NSLog(@"y==%@", self.yValueTextField.text);
    return YES;
}

-(void)updateCell:(NSInteger) row yValue:(NSString *)yvalue  {
    [self.yValueTextField setText: yvalue];
    self.key = [NSString stringWithFormat:@"Y%ld", (long)row];
    
    [self.yLable setText: [self.key stringByAppendingString: @" ="]];
}

@end
