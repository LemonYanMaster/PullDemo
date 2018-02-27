//
//  PullListBtn.m
//  pullDemo
//
//  Created by pengpeng yan on 2016/11/25.
//  Copyright © 2016年 pengpeng yan. All rights reserved.
//

#import "PullListBtn.h"
@interface PullListBtn () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , copy  ) NSString    *rightImgName;
@property (nonatomic , strong) NSArray     *dataSource;
//@property (nonatomic , strong) UITableView *pullTabelView;
@end

@implementation PullListBtn

- (instancetype) initWithFrame:(CGRect)frame withRightImg:(NSString *)imageName{
    self  = [super initWithFrame:frame];
    if (self) {
        self.rightImgName = imageName;
        [self layoutSubViews];
    }
    return self;
}

- (void)layoutSubViews{
    [self setImage:[UIImage imageNamed:self.rightImgName] forState:UIControlStateNormal];
    self.layer.cornerRadius = 5.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0.8f;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor lightGrayColor];
    CGSize imageSize = self.imageView.frame.size;
    CGFloat padSize = (self.frame.size.width - self.titleLabel.frame.size.width -imageSize.width)/2;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, imageSize.width+ padSize)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, padSize+self.titleLabel.frame.size.width, 0, 0)];
//    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
//    self.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
}

- (void)addPullListWithDataSource:(NSArray *)titleArr withClickBlock:(ClickBlock)clickBlock{
    self.clickBlock = clickBlock;
    self.dataSource = titleArr;
    self.titleLabel.text = self.dataSource.firstObject;
    if (self.superview) {
        [self.superview addSubview:self.pullTabelView];
    }
}

- (void)chooseClick{
    if (self.pullTabelView.alpha) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pullTabelView.alpha = 0;
            self.pullTabelView.frame = CGRectMake(self.bounds.origin.x, CGRectGetMaxY(self.frame), self.bounds.size.width, 0);
        }];
    }else{
       [UIView animateWithDuration:0.3 animations:^{
           self.pullTabelView.alpha = 1.0f;
           self.pullTabelView.frame = CGRectMake(self.bounds.origin.x, CGRectGetMaxY(self.frame), self.bounds.size.width, MIN(self.dataSource.count, 5)*44);
           self.pullTabelView.scrollEnabled = (self.dataSource.count >= 5);
       }];
    }
}

#pragma mark - SystemDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];}

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //TODO
    self.titleLabel.text = self.dataSource[indexPath.row];
    [self chooseClick];
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
}

#pragma mark - propries
- (UITableView *)pullTabelView{
    if (!_pullTabelView) {
        _pullTabelView = [[UITableView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, CGRectGetMaxY(self.frame), self.bounds.size.width, 0) style:UITableViewStylePlain];
        _pullTabelView.scrollEnabled = NO;
        _pullTabelView.delegate = self;
        _pullTabelView.dataSource = self;
        _pullTabelView.alpha = 0; //设置tableview透明
        [_pullTabelView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(self.class)];
    }
    return _pullTabelView;
}

@end
