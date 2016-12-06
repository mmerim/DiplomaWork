//
//  CustomTableViewCell.h
//  DiplomaWork
//
//  Created by Meri on 12/5/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lagranji BanadzevViewController.h"

@interface CustomTableViewCell : UITableViewCell

-(void)updateCell:(NSInteger) row xValue:(NSString *)xvalue yValue:(NSString *)yValue;


@property(nonatomic,strong) id<TestProtocol> stacox;


@end
