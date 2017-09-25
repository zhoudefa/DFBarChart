//
//  DFBarChartItemCell.h
//  DFBarChart
//
//  Created by 周德发 on 2017/9/8.
//  Copyright © 2017年 周德发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

typedef enum : NSUInteger {
    DFBarChartItemCellValueShowTypeNone = 0,//不显示
    DFBarChartItemCellValueShowTypeValue,//值
    DFBarChartItemCellValueShowTypePercentage,//百分比
} DFBarChartItemCellValueShowType;


@interface DFBarChartItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *barView;
@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UIView *xView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barHeigth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xLabelH;
@property (weak, nonatomic) IBOutlet UILabel *valueLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueLBH;

@property(nonatomic,assign)DFBarChartItemCellValueShowType valueShowType;
@property(nonatomic,assign)double maxValue;
@property(nonatomic,assign)NSNumber *value;


-(void)animationToHeigth:(CGFloat )heigth;

@property(nonatomic,strong)UICountingLabel *valueLabel;

@end
