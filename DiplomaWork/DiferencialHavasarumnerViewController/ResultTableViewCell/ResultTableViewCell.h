//
//  ResultTableViewCell.h
//  DiplomaWork
//
//  Created by Meri on 5/14/17.
//  Copyright © 2017 Meri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"
#import "HeaderDiferencial.h"


@interface ResultTableViewCell : UITableViewCell <TestProtocol>

-(void)setVvalueID:(NSInteger)ID xValue:(NSNumber *)xValue yValue:(NSNumber *)yValue;

@end
