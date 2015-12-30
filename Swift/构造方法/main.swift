//
//  main.swift
//  构造方法
//
//  Created by 徐闯楠 on 15/4/4.
//  Copyright (c) 2015年 xcn. All rights reserved.
//

import Foundation

/*
构造方法:
作用: 对实例对象的内容进行初始化
Swift要求类或者结构体中的存储属性(非lazy的)在对象构造完毕后要有初始化值
语法:
init(参数列表){ 初始化代码 }
注意: 1.在Swift中类/结构体/枚举都需要构造方法
2.构造方法的作用仅仅是用于初始化属性, 而不是分配内容, 分配内存是系统帮我们做的
3.构造方法是隐式调用的, 通过 类名称() 形式创建一个对象就会隐式调用init()构造方法
4.如果所有的存储属性都有默认值, 可以不提供构造方法, 系统会提供一个隐式的构造方法
5.如果存储属性可以提供缺省, 那么提倡大家使用设置缺省值的方式, 这样可以简化代码(不用自定义构造方法, 不用写存储属性类型)
*/

class Person {
    var name:String = "lnj"
//    var age:Int = 30
    var age:Int
    func description() ->String{
        return "name = \(name) age = \(age)"
    }
    init()
    {
        print("init")
        age = 30
    }
}
// 1.分配内存 2.初始化name和age 3.构造方法是隐式调用的
var p = Person()
p.description() //显示调用


/*
带参数的构造方法
*/

class Person2 {
    var name:String
    var age:Int
    func description() ->String{
        return "name = \(name) age = \(age)"
    }
    // 构造方法的内部参数, 默认也是外部参数
    // 而函数的内部参数默认不会当做外部参数
    // 而方法的内部参数, 从第二个开始才会当做外部参数
//    init(name:String, age:Int)
    // 构造方法对属性的顺序没有要求, 只要保证对象构造完时所有存储属性被初始化即可
    init(age:Int, name:String)
    {
        self.name = name
        self.age = age
    }
    func setName(name:String, age:Int)
    {
        
    }
}
//var p2 = Person(name: "lnj", age: 30)
var p2 = Person2(age: 30, name: "lnj")
p2.setName("lnj", age: 30)
func setName(name:String, age:Int)
{
    
}
p2.setName("lnj", age: 30)


/*
常量存储属性与构造方法
常量存储属性只能通过缺省值或在构造方法中被修改, 其它任何地方都不能修改
*/

class Person3 {
    var name:String = "lnj"
    var age:Int
    init(age:Int, name:String)
    {
        self.age = age
        self.name = name
    }
    func description() ->String{
        return "name = \(name) age = \(age)"
    }
}
var p3 = Person3(age: 30, name:"zs")
print(p3.description())
p3.age = 55
//p3.name = "xxx" // 常量存储属性初始化之后不允许被修改



/*
可选属性与构造方法
*/

class Car{
    let name:String
    init(name:String)
    {
        self.name = name
    }
}
class Person4 {
    let name:String
    var age:Int
    var car:Car?
    // 可选值存储属性可以不再构造方法中初始化, 
    // 也就是说可选值在对象构造完毕后不用初始化
    // 其实如果不对可选存储属性进行初始化, 默认就是nil
    init(age:Int, name:String)
    {
        self.age = age
        self.name = name
    }
    func description() ->String{
        return "name = \(name) age = \(age)"
    }
}


/*
结构体构造方法
*/

struct Rect{
    // 此事即没有提供缺省值, 也没有提供构造方法, 但是编译通过
    // 因为默认情况下, 结构体会给结构体提供一个默认的成员逐一构造器
    var width:Double = 0.0
    var heigth:Double = 0.0
    /*
    // 系统默认会提供一个类似的方法
    init(width:Double, height:Double)
    {
        self.width = width
        self.heigth = heigth
    }
    */
    /*
    init()
    {
        self.width = 0.0
        self.heigth = 0.0
    }
    */
}
// 注意: 1.在类中默认是没有逐一构造器的
// 2.如果在结构体中自定义了构造方法, 那么系统不会生成默认的逐一构造器
// 3.如果给存储属性提供了缺省值, 系统还是会提供默认的逐一构造器
//var r = Rect(width: 1.0, heigth: 1.0)
// 4.如果给存储属性提供了缺省值, 可以使用不带参数的方法初始化结构体
var r = Rect()



/*
"值类型"的构造器代理
构造器代理: 构造方法之间的相互调用
构造方法可以调用其他构造方法来完成实例的构造, 称之为构造器代理
好处: 减少构造方法之间的重复代码
*/

struct Rect2 {
    var width:Double
    var height:Double
    init(width:Double, height:Double)
    {
        self.width = width
        self.height = height
    }
    init()
    {
//        self.width = 0
//        self.height = 0
        // 构造器代理
        self.init(width:0, height:0)
    }
    func show(){
        print("width = \(width) height = \(height)")
    }
}
var r2 = Rect2()
r2.show()
var r3 = Rect2(width: 100, height: 100)
r3.show()


/*
通过闭包或者全局函数/类方法 设置存储属性的缺省值
如果需要经过计算, 或者需要进行一些额外的操作才能确定初始值时就可以通过闭包或全局函数设置存储属性的缺省值
*/
func getValue() ->Int
{
    print("getValue")
    return 55
}
class Person5 {
    var name: String
    // 系统在初始化的时候会隐式执行闭包, 将闭包的执行结果赋值给存储属性
    // 注意: 闭包后面一定要有(), 代表执行闭包
    var age: Int = {
//        () -> Int in // 返回值可以省略, 默认返回值的类型就是存储属性的类型
        print("age 闭包")
        return 30
    }()
    lazy var height:Double = {
        print("lazy 闭包")
       return 175.0
    }()
    
    var age2:Int = getValue()
    var age3:Int = Person5.getValue2()
    // 不能这样写, 因为调用方法时对象还没有初始化完毕
    // self只有当所有的存储属性都初始化完毕之后才可以用
//    var age3:Int = self.getValue3()
    init(name:String)
    {
        print("init")
        self.name = name
    }
    class func getValue2() -> Int{
        print("class getValue2")
        return 100
    }
    func getValue3() -> Int
    {
        return 88
    }
}
var p5 = Person5(name: "lnj")
// 懒加载是用到时才执行, 而闭包赋值是初始化时就会执行
print(p5.height)
