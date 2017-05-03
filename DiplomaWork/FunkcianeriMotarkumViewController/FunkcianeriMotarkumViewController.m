//
//  FunkcianeriMotarkumViewController.m
//  DiplomaWork
//
//  Created by Meri on 12/3/16.
//  Copyright © 2016 Meri. All rights reserved.
//

#import "FunkcianeriMotarkumViewController.h"

@interface FunkcianeriMotarkumViewController ()

@property (weak, nonatomic) IBOutlet UIButton *LagranjButton;
@property (weak, nonatomic) IBOutlet UIButton *NyutonButton;
@property (weak, nonatomic) IBOutlet UIButton *erkuPopFuncButton;

@end

@implementation FunkcianeriMotarkumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Math-1.png"]];
    
    self.LagranjButton.titleLabel.numberOfLines =0;
    [self.LagranjButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.LagranjButton setTitle:@"Լագրանժի ինտերպոլացիոն բանաձեւ" forState:
     UIControlStateNormal];
    
    
    self.NyutonButton.titleLabel.numberOfLines =0;
    [self.NyutonButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.NyutonButton setTitle:@"Նյուտոնի ինտերպոլացիոն բանաձեւ" forState:UIControlStateNormal];
    
    self.erkuPopFuncButton.titleLabel.numberOfLines =0;
    [self.erkuPopFuncButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.erkuPopFuncButton setTitle:@"Երկու փոփոխականի ֆունկցիայի ինտերպոլացիոն բանաձեւ" forState:UIControlStateNormal];
    
    self.navigationItem.title = @"Ֆունկցիաների մոտարկում";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
