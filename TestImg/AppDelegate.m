//
//  AppDelegate.m
//  TestImg
//
//  Created by villa on 2017/11/14.
//  Copyright © 2017年 Villaday. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)mergeWithSourceArray:(NSMutableArray *)sourceArr startIndex:(NSInteger)startIndex midIndex:(NSInteger)midIndex endIndex:(NSInteger)endIndex {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < sourceArr.count; i++) {
        [array addObject:@-111];
    }
    NSInteger i = startIndex, j= midIndex+1, k = startIndex;
    // k++ 先赋值，再自增， ++k先自增，再赋值
    while (i < midIndex+1 && j < endIndex+1) {
        if ([sourceArr[i] integerValue] > [sourceArr[j] integerValue]) {
            [array replaceObjectAtIndex:k++ withObject:sourceArr[j++]];

        } else {
            [array  replaceObjectAtIndex:k++ withObject:sourceArr[i++]];

        }
    }
    while (i < midIndex+1) {
        [array  replaceObjectAtIndex:k++ withObject:sourceArr[i++]];

    }
    while (j < endIndex+1) {
        [array replaceObjectAtIndex:k++ withObject:sourceArr[j++]];

    }
    
    for (NSInteger m = startIndex; m < endIndex+1; m++) {
        if (![array[m] isEqualToNumber:@-111]) {
            sourceArr[m] = array[m];
        }
    }
    
}

- (void)mergeSortWithSourceArray:(NSMutableArray *)sourceArr startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    
    NSInteger midIndex = 0;
    //先拆分为最小比较单位，在合并比较
    if (startIndex < endIndex) {
        midIndex = (startIndex + endIndex)/2;
        [self mergeSortWithSourceArray:sourceArr startIndex:startIndex endIndex:midIndex];
        [self mergeSortWithSourceArray:sourceArr startIndex:midIndex+1 endIndex:endIndex];
        [self mergeWithSourceArray:sourceArr startIndex:startIndex midIndex:midIndex endIndex:endIndex];
    }

}


- (void)quickSort:(NSMutableArray *)quickArray startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    //先选一个值交换分边，再递归
    if (startIndex < endIndex) {
        
        NSInteger i = startIndex, j = endIndex;
        NSNumber *key = quickArray[i];
        while (i < j) {
            
            while (i < j && [quickArray[j] integerValue] >= key.integerValue) {
                j --;
            }
            [quickArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            
            while (i < j && [quickArray[i] integerValue] <= key.integerValue) {
                i++;
            }
            [quickArray exchangeObjectAtIndex:i withObjectAtIndex:j];
        }
        
        [self quickSort:quickArray startIndex:startIndex endIndex:i-1];
        [self quickSort:quickArray startIndex:i+1 endIndex:endIndex];
        
    }
}

//array是待调整的堆数组，i是待调整的数组元素的位置，nlength是数组的长度
//本函数功能是：根据数组array构建大根堆
void HeapAdjust(int array[],int i,int nLength)
{
    int nChild;
    int nTemp;
    for(;2*i+1<nLength;i=nChild)
    {
        //子结点的位置=2*（父结点位置）+1
        nChild=2*i+1;
        //得到子结点中较大的结点
        if(nChild<nLength-1&&array[nChild+1]>array[nChild])++nChild;
        //如果较大的子结点大于父结点那么把较大的子结点往上移动，替换它的父结点
        if(array[i]<array[nChild])
        {
            nTemp=array[i];
            array[i]=array[nChild];
            array[nChild]=nTemp;
        }
        else break; //否则退出循环
    }
}
//堆排序算法
void HeapSort(int array[],int length)
{
    int i;
    //调整序列的前半部分元素，调整完之后第一个元素是序列的最大的元素
    //length/2-1是最后一个非叶节点，此处"/"为整除
    for(i=length/2-1;i>=0;--i)
        HeapAdjust(array,i,length);
    //从最后一个元素开始对序列进行调整，不断的缩小调整的范围直到第一个元素
    for(i=length-1;i>0;--i)
    {
        //把第一个元素和当前的最后一个元素交换，
        //保证当前的最后一个位置的元素都是在现在的这个序列之中最大的
        array[i]=array[0]^array[i];
        array[0]=array[0]^array[i];
        array[i]=array[0]^array[i];
        //不断缩小调整heap的范围，每一次调整完毕保证第一个元素是当前序列的最大值
        HeapAdjust(array,0,i);
    }
}

- (void)HeapAdjust:(NSMutableArray *)heapArray note:(NSInteger)note length:(NSInteger)length {
    //指针关系为成二叉树状
    NSInteger child = 0;
    for (; note*2+1 < length; note = child) {
        child = 2*note + 1;
        if (child < length) {
            
            if (child +1 < length && heapArray[child+1] > heapArray[child]) {
                child ++;
            }
            
            if (heapArray[note] < heapArray[child]) {
                [heapArray exchangeObjectAtIndex:note withObjectAtIndex:child];
            } else {
                break;
            }
            
        }
    }
    
    
}

- (void)HeapSort:(NSMutableArray *)heapArray {
    NSUInteger length = heapArray.count;
    for (NSInteger i = length/2-1; i>=0; --i) {
        
        [self HeapAdjust:heapArray note:i length:length];
        NSLog(@"%li__%@",(long)i,[heapArray componentsJoinedByString:@"->"]);
    }
    
    for (NSInteger i = length-1; i>= 0; --i) {
        [heapArray exchangeObjectAtIndex:i withObjectAtIndex:0];
        
        [self HeapAdjust:heapArray note:0 length:i];
        NSLog(@"%li__%@",(long)i,[heapArray componentsJoinedByString:@"->"]);
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@50, @10, @20, @30, @70, @40, @80, @60, nil];
    [self mergeSortWithSourceArray:array startIndex:0 endIndex:array.count-1];
    
    NSLog(@"%@归并排序",[array componentsJoinedByString:@"->"]);
    
    //边交换边得到最小值
    NSMutableArray *maopaoArray = [[NSMutableArray alloc] initWithObjects:@50, @10, @20, @30, @70, @40, @80, @60, nil];
    for (int i = 0; i < maopaoArray.count-1; i++) {
        for (int j = i+1; j<maopaoArray.count; j++) {
            if (maopaoArray[i] > maopaoArray[j]) {
                [maopaoArray exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    NSLog(@"%@冒泡排序",[maopaoArray componentsJoinedByString:@"->"]);

    NSMutableArray *quickArray = [[NSMutableArray alloc] initWithObjects:@50, @30, @30, @30, @10, @20, @30, @30, @70, @40, @80, @60, @30, @30, @30, nil];
    [self quickSort:quickArray startIndex:0 endIndex:quickArray.count-1];
    NSLog(@"%@快速排序",[quickArray componentsJoinedByString:@"->"]);

    NSMutableArray *insertArray = [[NSMutableArray alloc] initWithObjects:@50, @10, @20, @30, @70, @40, @80, @60, nil];
    
    for (int i = 1; i< insertArray.count; i++) {
        
//        int j = i-1;
//        NSNumber *tem = insertArray[i];
//
//        while (j >= 0 && tem.integerValue < [insertArray[j] integerValue]) {
//            j--;
//        }
//        [insertArray removeObjectAtIndex:i];
//        [insertArray insertObject:tem atIndex:j+1];
        
        int j = i;
        
        while (j > 0 && [insertArray[j-1] integerValue] > [insertArray[j] integerValue]) {
            
            [insertArray exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
            j--;
        }

    }
    
    NSLog(@"%@插入排序",[insertArray componentsJoinedByString:@"->"]);
    
    NSMutableArray *selectArray = [[NSMutableArray alloc] initWithObjects:@50, @10, @20, @30, @70, @40, @80, @60, nil];
    //先选择最小值，然后再交换
    for (int i = 0; i< selectArray.count-1; i++) {
        int m = i;
        for (int j = i+1; j< selectArray.count; j++) {
            if (selectArray[j] < selectArray[m]) {
                m = j;
            }
        }
        if (m != i) {
            [selectArray exchangeObjectAtIndex:m withObjectAtIndex:i];
        }
    }
    NSLog(@"%@直接选择排序",[selectArray componentsJoinedByString:@"->"]);
    
    
    NSMutableArray *shellArray = [[NSMutableArray alloc] initWithObjects:@50, @10, @20, @30, @70, @40, @80, @60, @6,nil];
    //间隔逐渐缩小为1
    for (NSInteger gap = shellArray.count/2; gap > 0; gap /= 2) {
        
        for (NSInteger i = 0; i < gap; i ++) {
            
            for (NSInteger j = i+gap; j< shellArray.count; j += gap) {
                
                NSInteger range = j-gap;
                NSNumber *temp = shellArray[j];
                if (temp.integerValue < [shellArray[range] integerValue]) {
                    
                    while (range >= 0 && temp.integerValue < [shellArray[range] integerValue]) {
                        
                        [shellArray exchangeObjectAtIndex:range withObjectAtIndex:range+gap];
                        range -= gap;
                    }
                    
                }
            }
        }
        NSLog(@"间隔：%li，排序后为：%@Shell排序", (long)gap,[shellArray componentsJoinedByString:@"->"]);
    }
    NSLog(@"%@Shell排序",[shellArray componentsJoinedByString:@"->"]);
    
    
    NSMutableArray *heapArray = [[NSMutableArray alloc] initWithObjects:@50, @10, @20, @30, @70, @40, @80, @60, @6,nil];
    [self HeapSort:heapArray];
    NSLog(@"%@堆排序",[heapArray componentsJoinedByString:@"->"]);

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
