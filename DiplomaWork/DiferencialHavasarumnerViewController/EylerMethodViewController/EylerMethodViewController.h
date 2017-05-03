//
//  EylerMethodViewController.h
//  DiplomaWork
//
//  Created by Meri on 4/16/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderDiferencial.h"

@interface EylerMethodViewController  : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, TestProtocol>

// for indexes
@property (assign, nonatomic) NSInteger numberOfN;

-(NSInteger)countEyler;

@end
