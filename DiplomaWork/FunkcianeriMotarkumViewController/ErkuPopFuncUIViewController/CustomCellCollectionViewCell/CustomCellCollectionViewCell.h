//
//  CustomCellCollectionViewCell.h
//  DiplomaWork
//
//  Created by Meri on 1/27/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErkuPopFuncUIViewController.h"

@interface CustomCellCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lable;
@property (weak, nonatomic) IBOutlet UITextField *textField;

-(void)updateCell:(NSInteger) row zValue:(NSString *)zvalue;


@property(nonatomic,strong) id<TestProtocol> stacox;

-(void)setDataWithIndexPath:(NSIndexPath *)indexPath;

@end
