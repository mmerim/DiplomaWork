//
//  CustomTableViewCellErkuPop.m
//  DiplomaWork
//
//  Created by Meri on 5/10/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import "CustomTableViewCellErkuPop.h"

@interface CustomTableViewCellErkuPop() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *zLable;
@property (weak, nonatomic) IBOutlet UITextField *zValueTF;

@property(strong, nonatomic)NSString *key;\

@end

@implementation CustomTableViewCellErkuPop

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
        [self.zValueTF setText: @""];
        return YES;
    }
    [self.stacox saveValue:self.zValueTF.text keyZ:self.key];
    return YES;
}

-(void)updateCell:(NSInteger) row zValue:(NSString *)zvalue  {
    [self.zValueTF setText: zvalue];
    self.key = [NSString stringWithFormat:@"Z%ld", (long)row];
    
    
    [self.zLable setText: [self.key stringByAppendingString: @" ="]];
}


@end
