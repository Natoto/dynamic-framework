//
//  ViewController.m
//  DynamicLibrary
//
//  Created by WM on 2016/11/28.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //动态库测试
    [self performSelector:@selector(dynamicLibraryClick) withObject:nil];

}
-(void)dynamicLibraryClick {
    // document路径
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = nil;
    if ([paths count] != 0) {
        documentDirectory = [paths objectAtIndex:0];
        NSLog(@"\nDocuments 路径 = %@\n",documentDirectory);
    }
    //拼接我们放到document中的framework路径
    NSString * libName = @"/DynamicLink.framework";
    NSString * destLibPath = [documentDirectory stringByAppendingString:libName];
    NSFileManager * manager = [NSFileManager defaultManager];
    //判断一下有没有这个文件的存在　如果没有直接跳出
    if (![manager fileExistsAtPath:destLibPath]) {
        NSLog(@"There isn't have the file");
        return;
    }
    //复制到程序中
    NSError * error = nil;
    
    //加载方式二：使用NSBundle加载动态库
    NSBundle * frameworkBundle = [NSBundle bundleWithPath:destLibPath];
    if (frameworkBundle && [frameworkBundle load]) {
        NSLog(@"bundle load framework success");
    } else {
        NSLog(@"bundle load framework err:%@",error);
        return;
    }
    
    //通过NSClassFromString方式读取类,FrameWorkStart为动态库中入口类
    Class pacteraClass = NSClassFromString(@"DynamicOpenMenth");
    if (!pacteraClass) {
        NSLog(@"Unable to get TestDyLib class");
        return;
    }
    
    // 1.初始化方式采用下面的形式,alloc　init的形式是行不通的,同样，直接使用PacteraFramework类初始化也是不正确的
    // 2.通过- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
    // 3.方法调用入口方法（startWithObject:withBundle:），并传递参数（withObject:self withObject:frameworkBundle）
    NSObject *pacteraObject = [pacteraClass new];
    [pacteraObject performSelector:@selector(startWithObject:withBundle:) withObject:self withObject:frameworkBundle];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
