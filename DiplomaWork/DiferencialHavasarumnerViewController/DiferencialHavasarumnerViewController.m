//
//  DiferencialHavasarumnerViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "DiferencialHavasarumnerViewController.h"

@interface DiferencialHavasarumnerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *EylerButton;
@property (weak, nonatomic) IBOutlet UIButton *otherEylerButton;
@property (weak, nonatomic) IBOutlet UIButton *RungKortButton;

@end

@implementation DiferencialHavasarumnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Դիֆերենցիալ հավասարումներ";
    
    self.EylerButton.titleLabel.numberOfLines =0;
    [self.EylerButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.EylerButton setTitle:@"Էյլերի մեթոդ" forState:UIControlStateNormal];
    
    self.otherEylerButton.titleLabel.numberOfLines =0;
    [self.otherEylerButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.otherEylerButton setTitle:@"Էյլերի ձեւափոխված մեթոդ" forState:UIControlStateNormal];
    
    self.RungKortButton.titleLabel.numberOfLines =0;
    [self.RungKortButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.RungKortButton setTitle:@"Ռունգ-Կուտտի մեթոդ" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
