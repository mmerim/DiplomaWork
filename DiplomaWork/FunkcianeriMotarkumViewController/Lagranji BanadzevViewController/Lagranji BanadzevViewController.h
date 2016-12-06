//
//  Lagranji BanadzevViewController.h
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface Lagranji_BanadzevViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, TestProtocol>

-(NSInteger)countLagrange;
@end
