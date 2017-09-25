//
//  DFBarChartView.h
//  DFBarChart
//
//  Created by 周德发 on 2017/9/8.
//  Copyright © 2017年 周德发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFBarChartYModel.h"

@class DFBarChartView;

@protocol DFBarChartViewDelegate <NSObject>



@end



@protocol DFBarChartViewDateSource <NSObject>


//总共显示多少个柱图
- (NSInteger)numberOfBarInBarChartView:(DFBarChartView *_Nullable)barChartView;

//总共多少个Y轴的Label
- (NSInteger)numberOfYLabelInBarChartView:(DFBarChartView *_Nullable)barChartView;

//第几个bar的值是多少
- (NSNumber *_Nullable)barChartView:(DFBarChartView *_Nullable)barChartView valueForBarIndex:(NSInteger )barIndex;


//每个柱的标识title
- (nullable NSString *)barChartView:(DFBarChartView *_Nullable)barChartView titleForBarIndex:(NSInteger)barIndex;


//对应的yLabel显示什么
- (NSString *_Nullable)barChartView:(DFBarChartView *_Nullable)barChartView titleForYLabelIndex:(NSInteger )yLabelIndex;


//第几个bar的背景颜色是什么色
- (UIColor *_Nullable)barChartView:(DFBarChartView *_Nullable)barChartView backgroundColorForBarIndex:(NSInteger )barIndex;


//第几个bar的颜色是什么色
- (UIColor *_Nullable)barChartView:(DFBarChartView *_Nullable)barChartView colorForBarIndex:(NSInteger )barIndex;

//第几个y颜色是什么色
- (UIColor *_Nullable)barChartView:(DFBarChartView *_Nullable)barChartView colorForYLine:(NSInteger )yLineIndex;


//间距
- (CGFloat )spacingOfBarChartView:(DFBarChartView *_Nullable)barChartView;


//宽度
- (CGFloat )widthOfBarChartView:(DFBarChartView *_Nullable)barChartView;

@end




typedef enum : NSUInteger {
    DFBarChartViewValueShowTypeNone = 0,//不显示
    DFBarChartViewValueShowTypeValue,//值
    DFBarChartViewValueShowTypePercentage,//百分比
} DFBarChartViewValueShowType;



@interface DFBarChartView : UIView


//@property (nonatomic, weak, nullable) id <DFBarChartViewDelegate> delegate;





@property (nonatomic, weak, nullable) id <DFBarChartViewDateSource> dataSource;


@property(nonatomic,assign)DFBarChartViewValueShowType valueShowType;


/**
 是否显示坐标轴
 */
@property (nonatomic,assign) BOOL isShowAxis;


/**
 坐标轴颜色
 */
@property (nonatomic,strong) UIColor * _Nullable axisColor;


/**
 内边距
 */
@property (nonatomic,assign) UIEdgeInsets edgeInsets;


/**
 左边Y轴标点Label的宽度
 */
@property (nonatomic,assign) CGFloat yLabelW;



/**
 y轴最大值
 */
@property (nonatomic,assign) double maxYValue;




/**
 刷新

 @param animation 是否动画
 */
- (void)reloadWithAnimation:(BOOL )animation;



@end
