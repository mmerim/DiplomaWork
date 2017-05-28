//
//  ProtocolMenu.h
//  RadioMariam
//
//  Created by Meri on 4/28/16.
//  Copyright © 2016 wedoapps. All rights reserved.
//

#ifndef ProtocolMenu_h
#define ProtocolMenu_h



@protocol ProtocolMenu

@optional
/*
 *@brief Close menu page
 */
- (void)closeMenu;

/*
 *@brief Clicked items of menu
 *@param index The index of menu.
 */
- (void)clickedMenuItems:(NSInteger) index;


/*
 *@brief Show text image
 */
-(void)showTextImage:(UIImageView*)image;

@end

#endif /* ProtocolMenu_h */
