//
//  ErkuPopFuncUIViewController.h
//  DiplomaWork
//
//  Created by Meri on 12/7/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "CustomTableViewCellErkuPop.h"

@interface ErkuPopFuncUIViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, TestProtocol>

-(NSInteger)countErkuPopoxakan;

@end
