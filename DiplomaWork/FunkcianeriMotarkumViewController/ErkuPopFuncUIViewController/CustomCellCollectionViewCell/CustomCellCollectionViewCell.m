//
//  CustomCellCollectionViewCell.m
//  DiplomaWork
//
//  Created by Meri on 1/27/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import "CustomCellCollectionViewCell.h"

@interface CustomCellCollectionViewCell()

//@property (weak, nonatomic) IBOutlet UILabel *lable;


@property(strong, nonatomic)NSString *key;

@end

@implementation CustomCellCollectionViewCell

-(void)setDataWithIndexPath:(NSIndexPath *)indexPath
{
    self.lable.text = [NSString stringWithFormat: @"%ld",(long)indexPath.row];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    //bolor@ tver chen
    if ([textField.text rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) {
        [self.textField setText: @""];
        return YES;
    }
    [self.stacox saveValue:self.textField.text keyZ:self.key];
    return YES;
}

-(void)updateCell:(NSInteger) row zValue:(NSString *)zvalue  {
    [self.textField setText: zvalue];
    self.key = [NSString stringWithFormat:@"Y%ld", (long)row];
    
    
    [self.lable setText: [self.key stringByAppendingString: @" ="]];
}


@end
