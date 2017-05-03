//
//  IntegralneriHashvumViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "IntegralneriHashvumViewController.h"

@interface IntegralneriHashvumViewController ()

@property (weak, nonatomic) IBOutlet UIButton *UxxankyunButton;
@property (weak, nonatomic) IBOutlet UIButton *SexanButton;
@property (weak, nonatomic) IBOutlet UIButton *SimpsonButton;

@end

@implementation IntegralneriHashvumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Թվային ինտեգրում";
    
    self.UxxankyunButton.titleLabel.numberOfLines =0;
    [self.UxxankyunButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.UxxankyunButton setTitle:@"Ուղղանկյան բանաձեւ" forState:UIControlStateNormal];
    
    self.SexanButton.titleLabel.numberOfLines =0;
    [self.SexanButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.SexanButton setTitle:@"Սեղանի բանաձեւ" forState:UIControlStateNormal];
    
    self.SimpsonButton.titleLabel.numberOfLines =0;
    [self.SimpsonButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.SimpsonButton setTitle:@"Սիմպսոնի բանաձեւ" forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
