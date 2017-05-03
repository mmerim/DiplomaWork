//
//  CustomDiferencialTableViewCell.m
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "CustomDiferencialTableViewCell.h"
#import "EylerMethodViewController.h"

@interface CustomDiferencialTableViewCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *aLable;
@property (weak, nonatomic) IBOutlet UITextField *aValueTextField;

@property(strong, nonatomic)NSString *key;

@end


@implementation CustomDiferencialTableViewCell

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
        [self.aValueTextField setText: @""];
        return YES;
    }
    [self.stacox saveValue:self.aValueTextField.text keyA:self.key];
    return YES;
}

-(void)updateCell:(NSInteger) row aValue:(NSString *)yvalue  {
    [self.aValueTextField setText: yvalue];
    EylerMethodViewController *e = [[EylerMethodViewController alloc]init];
    for(int i = 0; i <= e.numberOfN; ++i) {
        for(int j = 0; j <= e.numberOfN - i; ++j) {
            NSLog(@"%d %d", i, j);
            self.key = [NSString stringWithFormat:@"a%d%d", i, j];
        }
    }
//    self.key = [NSString stringWithFormat:@"a%ld", (long)row];
    [self.aLable setText: [self.key stringByAppendingString: @" ="]];
}

@end
