//
//  CustomTableViewCellErkuPop.h
//  DiplomaWork
//
//  Created by Meri on 5/10/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErkuPopFuncUIViewController.h"

@interface CustomTableViewCellErkuPop : UITableViewCell

-(void)updateCell:(NSInteger) row zValue:(NSString *)zvalue;

@property(nonatomic,strong) id<TestProtocol> stacox;




@end
