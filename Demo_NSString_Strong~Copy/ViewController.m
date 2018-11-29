//
//  ViewController.m
//  Demo_NSString_Strong~Copy
//
//  Created by Geraint on 2018/11/29.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#pragma mark -- 来源地址：https://www.jianshu.com/p/62913d6cbc40


#import "ViewController.h"

@interface ViewController ()


/*
    注：不能以alloc、new、copy、mutableCopy 作为开头命名，比如：copyStr 回报错
 */
@property (nonatomic, strong) NSString *strongStr;
@property (nonatomic, copy) NSString *copyyStr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
        第一种场景：用NSString直接赋值
     */
    NSString *originStr1 = [NSString stringWithFormat:@"hello, everyone"];
    
    _strongStr = originStr1;
    _copyyStr = originStr1;
    
    NSLog(@"第一种场景：用NSString直接赋值");
    NSLog(@"           对象地址         对象指针地址          对象的值     ");
    NSLog(@"originStr1: %p , %p , %@", originStr1, &originStr1, originStr1);
    NSLog(@"strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
    NSLog(@" copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    
    /*
        打印结果：
     第一种场景：用NSString直接赋值
                对象地址           对象指针地址          对象的值
     originStr1: 0x600000626460 , 0x7ffeeb3be958 , hello, everyone
     originStr:  0x600000626460 , 0x7ffeeb3be958 , hello, everyone
      copyyStr:  0x600000626460 , 0x7ff76f50d078 , hello, everyone
     
     结论： 这种情况下，不管是用strong还是copy修饰的对象，其指向的地址都是originStr钉钉地址
     */
    
    
    /**
            第二种场景：用NSMutableString直接赋值
     */
    NSMutableString *originStr2 = [NSMutableString stringWithFormat:@"hello, everyone"];
    
    _strongStr = originStr2;
    _copyyStr = originStr2;
    
    [originStr2 setString:@"hello, QiShare"];
    
    NSLog(@"第二种场景：用NSMutableString直接赋值");
    NSLog(@"           对象地址         对象指针地址          对象的值     ");
    NSLog(@"originStr2: %p , %p , %@", originStr2, &originStr2, originStr2);
    NSLog(@" strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
    NSLog(@"  copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    
    /*
        打印结果：
      第二种场景：用NSMutableString直接赋值
                对象地址         对象指针地址          对象的值
      originStr2: 0x60000325f360 , 0x7ffeee60d950 , hello, QiShare
      strongStr:  0x60000325f360 , 0x7fa03751ba10 , hello, QiShare
       copyyStr:  0x60000325f360 , 0x7fa03751ba18 , hello, QiShare
     
     结论：
     */
    
    
    /**
        第三种场景：用NSMutableString点语法赋值
     */
    NSMutableString *originStr3 = [NSMutableString stringWithFormat:@"hello, everyone"];
    
    self.strongStr = originStr3;
    self.copyyStr = originStr3;
    
    [originStr3 setString:@"hello, QiShare"];
    
    NSLog(@"第三种场景：用 NSMutableString 点语法赋值");
    NSLog(@"           对象地址         对象指针地址          对象的值     ");
    NSLog(@"originStr3: %p , %p , %@", originStr3, &originStr3, originStr3);
    NSLog(@" strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
    NSLog(@"  copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    
    /*
        打印结果：
     第三种场景：用 NSMutableString 点语法赋值
                对象地址         对象指针地址          对象的值
      originStr3: 0x600003561e00 , 0x7ffee1ddc948 , hello, QiShare
       strongStr: 0x600003561e00 , 0x7fc7f96276e0 , hello, QiShare
        copyyStr: 0x600003561f50 , 0x7fc7f96276e8 , hello, everyone
     
        结论：_copyyStr依然是“hello, everone”，没有变成“hello, QiShare”,
        _copyyStr指针指向的 地址 不再是_originStr的地址。
     
        当我们用@property来声明属性变量时，编译器会自动为我们生成一个 以下划线加属性名命名的实例变量（@synthesize copyyStr = _copyyStr）,并且生成其对应的getter、setter方法。
        当我们用 self.copyyStr = originStr 赋值时，会调用copyyStr的setter方法，而_copyyStr = originstr
      赋值时给_copyyStr实例变量直接赋值，并不会调用copyyStr的setter方法，而在【setter方法】中一个非常【关键】的语句：
        _copyyStr = [copyyStr copy];
     
        结论2：第三种场景中，用self.copyyStr = originStr 赋值时，调用copyyStr的setter方法，setter方法对传入的copyyStr做了一次【深拷贝】生成了一个新的对象赋值给_copyyStr ，所以_copyyStr指向的地址和对象值都不再和originStr相同。
     */
    
    
    /**
        第四种场景：用NSString 点语法赋值
     */
    NSString *originStr4 = [NSString stringWithFormat:@"hello, everyone"];
    
    self.strongStr = originStr4;
    self.copyyStr = originStr4;
    
    NSLog(@"第四种场景：用 NSString 点语法赋值");
    NSLog(@"           对象地址         对象指针地址          对象的值     ");
    NSLog(@"originStr4: %p , %p , %@", originStr4, &originStr4, originStr4);
    NSLog(@" strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
    NSLog(@"  copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    
    /*
        打印结果：
     第四种场景：用 NSString 点语法赋值
                 对象地址         对象指针地址          对象的值
      originStr4: 0x60000218a400 , 0x7ffeed8f3940 , hello, everyone
       strongStr: 0x60000218a400 , 0x7fc311e036c0 , hello, everyone
        copyyStr: 0x60000218a400 , 0x7fc311e036c8 , hello, everyone
     
        结论：这里的copy是【浅拷贝】，并没有生成新的对象，所以，调用_copyyStr = [copyyStr copy]之后，_copyyStr指向的地址和originStr的地址还是相同。
     */
    
}

#pragma mark -- 总结：
/**
        由上面的例子可以得出：
    1、当原字符串是NSString时，由于是【不可变字符串】，所以，不管使用strong还是copy修饰，都是指向原来的对象，copy操作只是做了一次【浅拷贝】。
    2、而当源字符串是NSMutableString时，strong只是将源字符串的引用计数加1，而copy则是对原字符串做了次【深拷贝】，从而生成了一个新的对象，并且copy的对象指向这个新对象。另外需要注意的是，这个copy属性对象的类型始终是NSString，而不是NSMutableString，如果想让拷贝过来的对象是可变的，就要使用mutableCopy。
    *   所以，如果源字符串是NSMutableString的时候，使用strong只会增加【引用计数】。
    *   但是copy会执行一次【深拷贝】，会造成不必要的内存浪费。而如果原字符串是NSString时，strong和copy效果一样，就不会有这个问题。
    但是，我们一般声明NSString时，也不希望它改变，所以一般情况下，建议使用copy，这样可以避免NSMutableString带来的错误。
 
 链接：https://www.jianshu.com/p/62913d6cbc40
 
 
 顺便路过提一下【assign】与【weak】：
 我们都知道，assign用来修饰基本数据类型，weak用来修饰OC对象。
 
 其实照理，assign也能修饰OC对象，但是assign修饰的对象在该对象释放后，其指针依然存在，不会被置为nil——这就造成了一个很严重的问题：出现了野指针。当访问这个野指针时，指向了原地址，而原地址是nil，所以会造成程序的crash。但是用weak来修饰的话，对象释放的时候会把指针置为nil，从而避免了野指针的出现。
 
 那又有个疑问出现了，凭什么基本数据类型就可以使用assign。这就要扯到堆和栈的问题了，基本数据类型会被分配到栈空间，而栈空间是由系统自动管理分配和释放的，就不会造成野指针的问题。
*/


@end
