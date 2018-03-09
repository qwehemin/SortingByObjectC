//
//  ViewController.m
//  TestImg
//
//  Created by villa on 2017/11/14.
//  Copyright © 2017年 Villaday. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ((void (*) (id, SEL)) objc_msgSend) (self, @selector(doSomething));
}


- (void)doSomething {
    NSLog(@"doSomething");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
