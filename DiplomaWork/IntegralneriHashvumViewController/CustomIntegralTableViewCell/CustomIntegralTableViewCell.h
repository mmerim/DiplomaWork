//
//  CustomIntegralTableViewCell.h
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UxxankyanBanadzevViewController.h"
#import "SexaniBanadzevViewController.h"
#import "SimpsoniBanadzevViewController.h"

@interface CustomIntegralTableViewCell : UITableViewCell

-(void)updateCell:(NSInteger) row yValue:(NSString *)yvalue;

@property(nonatomic,strong) id<TestProtocol> stacox;

@end
