//
//  MainMenuViewController.h
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolMenu.h"

@class MenuViewController;

@interface MainMenuViewController : UIViewController <ProtocolMenu>
/*
 *@brief Open Menu
 */
-(void)openMenu;
//@property(nonatomic,strong) id<ProtocolMenu> delegate;


@end
