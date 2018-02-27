//
//  PullListBtn.h
//  pullDemo
//
//  Created by pengpeng yan on 2016/11/25.
//  Copyright © 2016年 pengpeng yan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock) (NSInteger index);


@interface PullListBtn : UIButton
@property (nonatomic ,copy) ClickBlock clickBlock;
@property (nonatomic , strong) UITableView *pullTabelView;
- (instancetype) initWithFrame:(CGRect)frame withRightImg:(NSString *)imageName;

- (void) addPullListWithDataSource:(NSArray *)titleArr withClickBlock:(ClickBlock)clickBlock;

@end
