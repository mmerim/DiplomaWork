//
//  NewtoniBanadzevViewController.h
//  DiplomaWork
//
//  Created by Meri on 12/6/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface NewtoniBanadzevViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, TestProtocol>

-(NSInteger)countNewton;

@end
