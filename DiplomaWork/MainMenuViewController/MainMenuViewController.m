//
//  MainMenuViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MenuViewController.h"

@interface MainMenuViewController ()

//@property (weak, nonatomic) IBOutlet UINavigationItem *menuNavigationItem;
@property (weak, nonatomic) IBOutlet UIButton *FuncMotarkumButton;
@property (weak, nonatomic) IBOutlet UIButton *IntegrHashvumButton;
@property (weak, nonatomic) IBOutlet UIButton *DifHavasarumnerButton;


@property (nonatomic, assign) BOOL a;

/*The view controller object  for menu page*/
@property(nonatomic,retain) MenuViewController * viewController;

/*The constraint of menu view controller*/
@property(nonatomic,retain)  NSLayoutConstraint *menuLeftConstraint;

/*The button item of menu*/
@property (nonatomic, retain) UIBarButtonItem * menuBarButtonItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * aboutUsBarButtonItem;


@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"white.png"]];

  
    self.FuncMotarkumButton.titleLabel.numberOfLines =0;
    [self.FuncMotarkumButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.FuncMotarkumButton setTitle:@"Ֆունկցիաների մոտարկում" forState:UIControlStateNormal];
    
    self.IntegrHashvumButton.titleLabel.numberOfLines =0;
    [self.IntegrHashvumButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.IntegrHashvumButton setTitle:@"Թվային ինտեգրում" forState:UIControlStateNormal];
    
    self.DifHavasarumnerButton.titleLabel.numberOfLines =0;
    [self.DifHavasarumnerButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.DifHavasarumnerButton setTitle:@"Դիֆերենցիալ հավասարումներ" forState:UIControlStateNormal];
    
    self.menuBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStyleDone target:self action: @selector(menuButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = self.menuBarButtonItem;


}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self createMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 *@brief Chicked menu button
 */
-(void)menuButtonClicked
{
    [self openMenu];
}

/*
 *@brief Create menu page, set constraints
 */
-(void)createMenu
{
    if (NULL != self.viewController) {
        return;
    }
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier: @"MenuViewController"];
    self.viewController.delegate = self;
    UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
    self.viewController.view.translatesAutoresizingMaskIntoConstraints = FALSE;
    [mainWindow addSubview: self.viewController.view];
    
    
    NSArray *hconstraints = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-(0)-[view(w)]" options: 0 metrics:@{@"w":@([[UIScreen mainScreen] bounds].size.width)} views: @{@"view":self.viewController.view}];
    self.menuLeftConstraint = [hconstraints firstObject];
    [mainWindow addConstraints: hconstraints];
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-(0)-[view]-(0)-|" options: 0 metrics:NULL views: @{@"view":self.viewController.view}];
    [mainWindow addConstraints: constraints];
    
    self.menuLeftConstraint.constant = [[UIScreen mainScreen] bounds].size.width;
    [mainWindow layoutIfNeeded];
}

//Open menu page
-(void)openMenu
{
    if(self.navigationItem.leftBarButtonItem != nil) {
        self.a = FALSE;
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        self.a = TRUE;
    }
    self.navigationItem.rightBarButtonItem = nil;
    self.menuLeftConstraint.constant = 0 ;
    [UIView animateWithDuration:0.5 animations:^{
        UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
        [mainWindow layoutIfNeeded];
    }];
}

#pragma mark - menu controller delegate
//Clicked items of menu
- (void)clickedMenuItems:(NSInteger)index {
    [self closeMenu];
    NSLog(@"%ld", (long)index);
    switch (index) {
        case 1:
            [self performSegueWithIdentifier:@"LagrangeText" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"NewtonText" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"ErkuPopoxakanText" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"UxxankyunText" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"SexanText" sender:self];
            break;
        case 6:
            [self performSegueWithIdentifier:@"SimpsonText" sender:self];
            break;
        case 7:
            [self performSegueWithIdentifier:@"EylerText" sender:self];
            break;
        case 8:
            [self performSegueWithIdentifier:@"EylerDzevapoxvacText" sender:self];
            break;
        case 9:
            [self performSegueWithIdentifier:@"RungKuttText" sender:self];
        default:
            break;
    }
}

//Close menu page
-(void)closeMenu {
    self.navigationItem.leftBarButtonItem = self.aboutUsBarButtonItem;
    self.menuLeftConstraint.constant = [[UIScreen mainScreen] bounds].size.width;
    self.navigationItem.rightBarButtonItem = self.menuBarButtonItem;
    
    [UIView animateWithDuration:0.5 animations:^{
        UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
        
        [mainWindow layoutIfNeeded];
    }];
}


@end
