//
//  DFBarChartItemCell.m
//  DFBarChart
//
//  Created by 周德发 on 2017/9/8.
//  Copyright © 2017年 周德发. All rights reserved.
//

#import "DFBarChartItemCell.h"


@interface DFBarChartItemCell ()



@end

@implementation DFBarChartItemCell

-(void)animationToHeigth:(CGFloat )heigth
{
    self.barHeigth.constant = 0;
    [self layoutIfNeeded];
    switch (self.valueShowType) {
        case 0:
            self.valueLabel.text = @"";
            break;
        case 1:
            
            self.valueLabel.format = @"%d";
            [self.valueLabel countFrom:0.0 to:[self.value doubleValue] withDuration:0.5f];
            break;
        case 2:
            
            self.valueLabel.format = @"%.2f%%";
            [self.valueLabel countFrom:0.0 to:[self.value doubleValue]/self.maxValue * 100 withDuration:0.5f];
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.barHeigth.constant = heigth;

        [self layoutIfNeeded];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.valueLB.text = @"";
    self.valueLabel = [[UICountingLabel alloc]init];
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:self.valueLabel];
    self.valueLabel.text = @"";

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.valueLabel.frame = self.valueLB.frame;
}

@end
