//
//  DFBarChartView.m
//  DFBarChart
//
//  Created by 周德发 on 2017/9/8.
//  Copyright © 2017年 周德发. All rights reserved.
//

#import "DFBarChartView.h"
#import "DFBarChartItemCell.h"
#import "DFBarChartCell.h"

@interface DFBarChartView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,weak)UIView *yLabelView;

@property (nonatomic,assign) BOOL isAnimation;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign) BOOL isHaveDate;


@end

@implementation DFBarChartView

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.edgeInsets.left,self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom - 15) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundView = nil;
        _tableView.scrollEnabled = NO;
        _tableView.userInteractionEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerNib:[UINib nibWithNibName:@"DFBarChartCell" bundle:nil] forCellReuseIdentifier:@"DFBarChartCell"];
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        
        [self addSubview:self.yLabelView];
        [self addSubview:self.collectionView];
        [self addSubview:self.tableView];
        

    }
    return self;
}

-(UIView *)yLabelView
{
    if (!_yLabelView){
        UIView * yLabelView = [[UIView alloc]init];
        _yLabelView = yLabelView;
    }
    return _yLabelView;
}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGRect frame;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {
            CGFloat h = self.tableView.bounds.size.height / [self.dataSource numberOfYLabelInBarChartView:self];
            frame = CGRectMake(self.edgeInsets.left + self.yLabelW, self.edgeInsets.top + h/2, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right - self.yLabelW, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom - h/2);
        }else{
            frame = CGRectMake(self.edgeInsets.left + self.yLabelW, self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right - self.yLabelW, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
        }
//        CGRect frame = CGRectMake(self.edgeInsets.left + self.yLabelW, self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right - self.yLabelW, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
//        collectionView.collectionViewLayout = layout;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
        
        [collectionView registerNib:[UINib nibWithNibName:@"DFBarChartItemCell" bundle:nil] forCellWithReuseIdentifier:@"DFBarChartItemCell"];


    }
    return _collectionView;
}



-(void)initData
{
    self.isShowAxis = YES;
    self.axisColor = [UIColor darkGrayColor];
    self.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.yLabelW = 40.0;
    self.maxYValue = 100.0;
    self.isAnimation = YES;
    self.isHaveDate = NO;
    self.valueShowType = DFBarChartViewValueShowTypeNone;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.tableView.frame = CGRectMake(self.edgeInsets.left,self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom - 15);
    

    self.collectionView.frame = CGRectMake(self.edgeInsets.left + self.yLabelW, self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right - self.yLabelW, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
    

}

-(void)layout
{
    self.tableView.frame = CGRectMake(self.edgeInsets.left,self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
    

    self.collectionView.frame = CGRectMake(self.edgeInsets.left + self.yLabelW, self.edgeInsets.top, self.bounds.size.width - self.edgeInsets.left - self.edgeInsets.right - self.yLabelW, self.bounds.size.height - self.edgeInsets.top - self.edgeInsets.bottom - 15);

}


-(void)reloadWithAnimation:(BOOL)animation
{

    [self layout];
    self.isAnimation = animation;
    [self.tableView reloadData];
    [self.collectionView reloadData];

}

-(void)setMaxYValue:(double)maxYValue
{
    _maxYValue = maxYValue;
    [self reloadWithAnimation:self.isAnimation];
}

-(void)setYLabelW:(CGFloat)yLabelW
{
    _yLabelW = yLabelW;
    [self reloadWithAnimation:self.isAnimation];
}

-(void)setAxisColor:(UIColor *)axisColor
{
    _axisColor = axisColor;
    [self reloadWithAnimation:self.isAnimation];
}

-(void)setIsShowAxis:(BOOL)isShowAxis
{
    _isShowAxis = isShowAxis;
    [self reloadWithAnimation:self.isAnimation];
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self reloadWithAnimation:self.isAnimation];
}

-(void)setValueShowType:(DFBarChartViewValueShowType)valueShowType
{
    _valueShowType = valueShowType;
     [self reloadWithAnimation:self.isAnimation];
}


#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfBarInBarChartView:)]) {
        if ([self.dataSource numberOfBarInBarChartView:self] == 0) {
            
            
            self.isHaveDate = NO;
            return 20;

        }else{
            
            self.isHaveDate = YES;
            return [self.dataSource numberOfBarInBarChartView:self];

        }
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellId = @"DFBarChartItemCell";
    
    
    [collectionView registerNib:[UINib nibWithNibName:@"DFBarChartItemCell" bundle:nil] forCellWithReuseIdentifier:cellId];

    
    
    
    DFBarChartItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.maxValue = self.maxYValue;
    switch (self.valueShowType) {
        case 0:
            cell.valueShowType = 0;

            break;
        case 1:
            cell.valueShowType = 1;

            break;
        case 2:
            cell.valueShowType = 2;

            break;
        default:
            break;
    }
    //x轴
    cell.xView.backgroundColor = self.axisColor;
    cell.xView.hidden = YES;//X轴放到 tableView展示

    //xLabel
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {
        
        CGFloat h = self.tableView.bounds.size.height / [self.dataSource numberOfYLabelInBarChartView:self];
        
        cell.xLabelH.constant = h / 2 + 14;
    }else{
        cell.xLabelH.constant = 35;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:titleForBarIndex:)]) {
        if (self.isHaveDate) {
            cell.xLabel.text = [self.dataSource barChartView:self titleForBarIndex:indexPath.row];
        }else{
            cell.xLabel.text = @"";
        }
        
    }else{
        cell.xLabel.text = @"";
    }
    
    

    
    cell.barHeigth.constant = 0;
    [cell setNeedsLayout];
    [cell setNeedsDisplay];
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {
        CGFloat h = self.tableView.bounds.size.height / [self.dataSource numberOfYLabelInBarChartView:self] / 2;
        cell.valueLBH.constant = h;
    }else{
        cell.valueLBH.constant = 15;
    }
    
    
    
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(widthOfBarChartView:)]) {
        cell.barWidth.constant = [self.dataSource widthOfBarChartView:self];
    }else{
        cell.barWidth.constant = 30;
    }
    

    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:backgroundColorForBarIndex:)]) {
        cell.bgView.backgroundColor = [self.dataSource barChartView:self backgroundColorForBarIndex:indexPath.row];
    }else{
        cell.bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:colorForBarIndex:)]) {
        if (self.isHaveDate) {
            cell.barView.backgroundColor = [self.dataSource barChartView:self colorForBarIndex:indexPath.row];

        }else{
            cell.barView.backgroundColor = [UIColor redColor];

        }
    }else{
        cell.barView.backgroundColor = [UIColor redColor];
    }
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:valueForBarIndex:)]) {
        
        if (self.isHaveDate) {
            NSNumber *value = [self.dataSource barChartView:self valueForBarIndex:indexPath.row];
            CGFloat h = value.doubleValue/self.maxYValue * (collectionView.bounds.size.height - cell.xLabel.bounds.size.height - cell.valueLB.bounds.size.height);
            cell.value = value;
            if (self.isAnimation) {
                
                [cell animationToHeigth:h];
                
            }else{
                
                cell.barHeigth.constant = h;
                switch (self.valueShowType) {
                    case 0:
                        cell.valueLabel.text = @"";
                        break;
                    case 1:
                        cell.valueLabel.text = [NSString stringWithFormat:@"%@",value];
                        break;
                    case 2:
                        cell.valueLabel.text = [NSString stringWithFormat:@"%.2f%%",[value doubleValue]/self.maxYValue * 100];
                        break;
                    default:
                        break;
                }
            }

        }else{
            
            if (self.isAnimation) {
                [cell animationToHeigth:0];
            }else{
                cell.barHeigth.constant = 0;
            }
            cell.valueLabel.text = @"";
        }
        
       
    }else{
        cell.valueLabel.text = @"";
        cell.barHeigth.constant = 0;
    }
    

    
    return cell;
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(spacingOfBarChartView:)]) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(widthOfBarChartView:)]) {
            CGFloat w = [self.dataSource spacingOfBarChartView:self] + [self.dataSource widthOfBarChartView:self];
            return CGSizeMake(w, collectionView.bounds.size.height);
        }else{
            CGFloat w = [self.dataSource spacingOfBarChartView:self] + 30;
            return CGSizeMake(w, collectionView.bounds.size.height);
        }
    }else{
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(widthOfBarChartView:)]) {
            CGFloat w = 20 + [self.dataSource widthOfBarChartView:self];;
            return CGSizeMake(w, collectionView.bounds.size.height);
        }else{
            return CGSizeMake(40, collectionView.bounds.size.height);
        }
    }
    return CGSizeZero;
}



-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}





#pragma mack -- UITableViewDelegate,UITableViewDataSource
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {
        return [self.dataSource numberOfYLabelInBarChartView:self];
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"DFBarChartCell";
    DFBarChartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:titleForYLabelIndex:)]) {
        cell.yLabel.text = [self.dataSource barChartView:self titleForYLabelIndex:indexPath.row];
    }else{
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {

            NSInteger number = [self.dataSource numberOfYLabelInBarChartView:self];
            NSInteger value = ( number - indexPath.row - 1) * self.maxYValue / (number - 1);
        
            cell.yLabel.text = [NSString stringWithFormat:@"%ld",value];

        
        }else{
            cell.yLabel.text = @"";

        }

    }
    

    

    
    cell.labelViewW.constant = self.yLabelW;
    
    
    cell.yLine.hidden = !self.isShowAxis;
    
    cell.yLine.backgroundColor = self.axisColor;
    
    cell.backgroundColor=[UIColor clearColor];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {
        
        if (indexPath.row == [self.dataSource numberOfYLabelInBarChartView:self] - 1) {

            if (self.isShowAxis) {
                cell.line.hidden = NO;
                
                
                cell.line.backgroundColor = self.axisColor;

            }else{
                cell.line.hidden = YES;
            }
            
            
        }else{
            cell.line.hidden = NO;

            if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:colorForYLine:)]) {
                cell.line.backgroundColor = [self.dataSource barChartView:self colorForYLine:indexPath.row];
            }else{
                cell.line.backgroundColor = [UIColor clearColor];
                
            }

        }
    }else{
        cell.line.hidden = NO;

        if (self.dataSource && [self.dataSource respondsToSelector:@selector(barChartView:colorForYLine:)]) {
            cell.line.backgroundColor = [self.dataSource barChartView:self colorForYLine:indexPath.row];
        }else{
            cell.line.backgroundColor = [UIColor clearColor];
            
        }
    }
    
    cell.userInteractionEnabled = NO;
    
    return cell;
}

-(BOOL )tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfYLabelInBarChartView:)]) {
        return tableView.bounds.size.height / [self.dataSource numberOfYLabelInBarChartView:self];
    }
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}



-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}






@end
