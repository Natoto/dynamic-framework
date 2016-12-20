//
//  DynamicOpenMenth.m
//  DynamicLink
//
//  Created by WM on 2016/11/28.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "DynamicOpenMenth.h"
#import "ViewController.h"

@implementation DynamicOpenMenth

- (void)startWithObject:(id)object withBundle:(NSBundle *)bundle {

    //初始化第一个controller
    //这里的重点是资源文件的加载，通常我们在初始化的时候并不是很在意bundle：这个参数
    //其实我们所用到的图片、xib等资源文件都是在程序内部中获取的，所谓的NSBundle本质上就是一个路径，mainBundle指向的是.app下。
    //而如果我们不指定bundle，则会默认从.app路径下去寻找资源
    //不过很显然，我们的动态库是放到"主程序"的document文件下的,所以资源文件是不可能在[NSbundle mainBundle]中获取到的，也就是我们常用的[NSbundle mainBundle]中获取到的，所以这里我们需要指定bundle参数，这也是传递framework的路径的意义所在
    ViewController * vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:bundle];
    vc.root_bundle = bundle;
    //转换传递过来的mainCon参数，实现界面跳转
    UIViewController * viewCon = (UIViewController *)object;
    [viewCon presentViewController:vc animated:YES completion:^{
        NSLog(@"跳转到动态更新模块成功");
    }];
}

@end
