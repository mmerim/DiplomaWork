//
//  MenuViewController.m
//  DiplomaWork
//
//  Created by Meri
//  Copyright © 2016 Meri. All rights reserved.
//

#import "MenuCell.h"
#import "MenuViewController.h"
#import "AppDelegate.h"

#define MENUTITLES  @[@"", @"Լագրաժի ինտերպոլացիոն բանաձեւ", @"Նյուտոնի ինտերպոլացիոն բանաձեւ", @"Երկու փոփոխականի ֆունկցիայի ինտերպոլացիոն բանաձեւ", @"Ուղղանյան բանաձեւ", @"Սեղանի բանաձեւ", @"Սիմպսոնի բանաձեւ", @"Էյլերի մեթոդ", @"Էյլերի ձեւափոխված մեթոդ", @"Ռունգե-Կուտտի մեթոդ"]

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>

/*The tableView of menu*/
@property (nonatomic, weak) IBOutlet UITableView * tableView;

@end

@implementation MenuViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/*
 * @brief Clicked of menu button
 */
- (IBAction) menuButtonClicked
{
    [self.delegate closeMenu];
}

/*
 *@brief Count of section
 *@param tableView
 *@return Returned count of section
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/*
 *@brief Number of rows in section
 *@param tableView
 *@param section
 *@return Returned count of cell
 */
- (NSInteger)tableView:(UITableView *)tableView
            numberOfRowsInSection:(NSInteger)section {
    return MENUTITLES.count;
}

/*
 *@brief Create new object of MenuCell class, set background color, set title the text of row of indexPath
 *@param tableView
 *@param indexPath
 *@return Returned cell of menu
 */
- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell * menuCell = [tableView dequeueReusableCellWithIdentifier:@"menu"];
    menuCell.backgroundColor = [UIColor clearColor];
    menuCell.menuTitleLabel.text = [NSLocalizedString([MENUTITLES objectAtIndex:indexPath.row], nil) uppercaseString];
    if (([menuCell.menuTitleLabel.text  isEqual: @""])) {
        menuCell.userInteractionEnabled = false;
    }
    
    return menuCell;
}

/*
 *@brief Count of cell
 *@param tableView
 *@param indexPath
 *@return Returned count of indexPath
 */
- (CGFloat)tableView:(UITableView *)tableView
            heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  50;
}

/*
 *@brief To check the value of indexPath, if it is is equal 0 that close menu, else to view that row whitch is click ???
 *@param tableView
 *@param indexPath
 */
- (void)tableView:(UITableView *)tableView
            didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.delegate closeMenu];
    } else {
        [self.delegate clickedMenuItems:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
