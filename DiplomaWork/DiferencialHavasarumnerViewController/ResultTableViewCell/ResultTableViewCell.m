//
//  ResultTableViewCell.m
//  DiplomaWork
//
//  Created by Meri on 5/14/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import "ResultTableViewCell.h"

@interface ResultTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *xValue;
@property (weak, nonatomic) IBOutlet UILabel *yValue;

@end

@implementation ResultTableViewCell

-(void)setVvalueID:(NSInteger)ID xValue:(NSNumber *)xValue yValue:(NSNumber *)yValue {
//    if(0 == ID) {
//        self.ID.text = @"i";
//        self.xValue.text = @"Xi";
//        self.yValue.text = @"Yi";
//        return;
//    }
    self.ID.text = [NSString stringWithFormat:@"%ld", (long)ID];
    self.xValue.text = [NSString stringWithFormat:@"%f",xValue.doubleValue];
    self.yValue.text = [NSString stringWithFormat:@"%f",yValue.doubleValue];
    NSLog(@"ID = %@ , x = %f , y = %f ", self.ID, self.xValue.text.doubleValue, self.yValue.text.doubleValue);
}

@end
