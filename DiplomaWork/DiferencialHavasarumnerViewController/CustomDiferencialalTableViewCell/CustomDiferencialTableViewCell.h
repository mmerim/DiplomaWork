//
//  CustomDiferencialTableViewCell.h
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EylerMethodViewController.h"
#import "EyleriDzevapoxvacMethodViewController.h"
#import "RungKuttiMethodViewController.h"

@interface CustomDiferencialTableViewCell : UITableViewCell

-(void)updateCell:(NSInteger) row aValue:(NSString *)avalue;

@property(nonatomic,strong) id<TestProtocol> stacox;

@end
