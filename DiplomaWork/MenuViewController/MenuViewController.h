//
//  MenuViewController.h
//  RadioMariam
//
//  Created by Meri on 4/21/16.
//  Copyright © 2016 wedoapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolMenu.h"

@class CustomNavigationController;

@interface MenuViewController : UIViewController

/*The delegate of menu*/
@property (nonatomic, weak) id <ProtocolMenu> delegate;

@end
