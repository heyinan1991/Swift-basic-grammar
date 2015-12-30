//
//  main.swift
//  类型转换
//
//  Created by 徐闯楠 on 15/4/9.
//  Copyright (c) 2015年 xcn. All rights reserved.
//

import Foundation

/*
Swift不允许隐式类型转换, 但可以使用显示类型转换(强制类型转换)
OC:
int intValue = 10;
double doubleValue = (double)intValue;

Swift:
*/
var intValue:Int = 10
var doubleValue:Double
doubleValue = Double(intValue)
// 注意:Double()并不会修改intValue的值, 而是通过intValue的值生成一个临时的值赋值给doubleValue
print(intValue)
print(doubleValue)


