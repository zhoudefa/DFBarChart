//
//  DFBarChartCell.h
//  DFBarChart
//
//  Created by 周德发 on 2017/9/9.
//  Copyright © 2017年 周德发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFBarChartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UIView *yLine;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelViewW;

@end
