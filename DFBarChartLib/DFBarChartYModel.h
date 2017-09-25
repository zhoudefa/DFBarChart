//
//  DFBarChartYModel.h
//  DFBarChart
//
//  Created by 周德发 on 2017/9/8.
//  Copyright © 2017年 周德发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DFBarChartYModel : NSObject

@property (nonatomic,copy) NSNumber *value;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL isShowLine;
@property (nonatomic,strong) UIColor *color;

@end
