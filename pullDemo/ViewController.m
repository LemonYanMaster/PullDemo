//
//  ViewController.m
//  pullDemo
//
//  Created by pengpeng yan on 2016/11/25.
//  Copyright © 2016年 pengpeng yan. All rights reserved.
//
#import "PullListBtn.h"
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,strong) PullListBtn *pullList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pullList];
//    self.pullList.backgroundColor = [UIColor lightGrayColor];
    [self.pullList setTitle:@"1" forState:UIControlStateNormal];
//    self.pullList.titleLabel.text = @"121";
    [self.pullList addTarget:self action:@selector(pullAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pullAction:(UIButton *)sender{
    [self addPull];
}
- (void)addPull{
    if (self.pullList.pullTabelView.alpha) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pullList.pullTabelView.alpha = 0;
            self.pullList.pullTabelView.frame = CGRectMake(self.pullList.bounds.origin.x, CGRectGetMaxY(self.pullList.frame), self.pullList.bounds.size.width, 0);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.pullList.pullTabelView.alpha = 1.0f;
            self.pullList.pullTabelView.frame = CGRectMake(self.pullList.frame.origin.x, CGRectGetMaxY(self.pullList.frame), self.pullList.bounds.size.width, 3*44);

        }];
    }
    __weak typeof(self) weakSelf = self;
    NSArray *dataArr = @[@"11",@"2",@"3"];
   [self.pullList addPullListWithDataSource:dataArr withClickBlock:^(NSInteger index) {
       switch (index) {
           case 0:{
//               [weakSelf.pullList setTitle:dataArr[0] forState:UIControlStateNormal];
               weakSelf.pullList.titleLabel.text = dataArr[0];
               NSLog(@"1");
               break;
           }
           case 1:{
//               [weakSelf.pullList setTitle:dataArr[1] forState:UIControlStateNormal];
               [weakSelf.pullList.titleLabel setText:dataArr[1]];
               NSLog(@"2");
               break;
           }
           case 2:{
//               [weakSelf.pullList setTitle:dataArr[2] forState:UIControlStateNormal];
               [weakSelf.pullList.titleLabel setText:dataArr[2]];
               NSLog(@"3");
               break;
           }
           default:
               break;
       }
   }];
    
}

#pragma mark - propreties
- (PullListBtn *)pullList{
    if (!_pullList) {
        _pullList = [[PullListBtn alloc] initWithFrame:CGRectMake(10, 70, 100, 30) withRightImg:@"1.png"];
    }
    return _pullList;
}

//- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    self.pullList.pullTabelView.hidden = YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
