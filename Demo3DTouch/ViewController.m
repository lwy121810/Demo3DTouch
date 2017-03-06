//
//  ViewController.m
//  Demo3DTouch
//
//  Created by yons on 17/2/3.
//  Copyright © 2017年 yons. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "PeekViewController.h"

static NSString *kCellIdentifier = @"3dTouch";
@interface ViewController ()<UITableViewDataSource , UITableViewDelegate, UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self check3DTouch];
}

- (void)check3DTouch {
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {//3DTouch可用
        //注册协议
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else {//3DTouch不可用
        NSLog(@"3DTouch不可用");
    }
}


#pragma mark -UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = @"PEEK";
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PeekViewController *peekVc = [[PeekViewController alloc] init];
    [self.navigationController pushViewController:peekVc animated:YES];

}
#pragma mark - UIViewControllerPreviewingDelegate 进入预览模式 peek 预览控制器

/**
 深按控制器的时候会走该方法 返回想要预览的控制器
 
 @param previewingContext 上下文
 @param location 点按的point
 @return 返回想要预览的控制器 可以为nil
 */
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    PeekViewController *peekVc = [[PeekViewController alloc] init];
    //设置预览时控制器的size
    //    peekVc.preferredContentSize = CGSizeMake(200, 200);
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面(peek)
    CGFloat h = 50;
    CGFloat y = (self.view.height - h) * 0.5;
    CGRect sourceRect = CGRectMake(0, y, self.tableView.width, h);
    //sourceRect就是不被虚化的区域
    previewingContext.sourceRect = sourceRect;
    
    return peekVc;
}
//继续按压进入：实现该协议 pop（按用点力进入）
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    //跳转到预览控制器
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
//    [self.navigationController showDetailViewController:viewControllerToCommit sender:self];
}
- (void)unregisterForPreviewingWithContext:(id<UIViewControllerPreviewing>)previewing
{
    NSLog(@"unregisterForPreviewingWithContext");
}


@end
