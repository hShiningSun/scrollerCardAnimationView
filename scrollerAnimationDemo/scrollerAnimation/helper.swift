//
//  helper.swift
//  HomeForPets
//
//  Created by Admin on 2016/5/22.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

import UIKit


let hFamilyNames = UIFont.familyNames()
let titleColor = UIColor.blackColor()

let h_Screen_Bounds = UIScreen.mainScreen().bounds

let h_BLACK_COLOR:UIColor = UIColor.init(red: 34/255.0, green: 34/255.0 , blue: 45/255.0, alpha: 1.0)  //黑色 22222d
let h_DARK_GRY:UIColor = UIColor.init(red: 85/255.0, green: 85/255.0, blue: 93/255.0, alpha: 1)    //深灰 55555d
let h_MID_GAY:UIColor = UIColor.init(red: 136/255.0, green: 136/255.0, blue: 141/255.0, alpha: 1)  //中灰 88888d
let h_LIGHT_GAY:UIColor = UIColor.init(red: 201/255.0, green: 201/255.0, blue: 201/255.0, alpha: 1)    //浅灰 c9c9c9
let h_SEPLINE_GRAY:UIColor = UIColor.init(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1) //分隔线灰 dfdfdf
let h_BOTTOM_GAY:UIColor = UIColor.init(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)   //底灰 f6f6f6
let h_BLUE:UIColor = UIColor.init(red: 0/255.0, green: 188/255.0, blue: 212/255.0, alpha: 1)   //蓝色
let h_ORIGIN:UIColor = UIColor.init(red: 1.0, green: 156/255.0, blue: 0.0, alpha: 1)   //橙色
let h_LIGHT_ORIGIN:UIColor = UIColor.init(red: 1.0, green: 240/255.0, blue: 200/255.0, alpha: 1)   //浅橙
let h_BOTTOM_ORIGIN:UIColor = UIColor.init(red: 1.0, green: 249/255.0, blue: 227/255.0, alpha: 1)
let h_GREEN:UIColor = UIColor.init(red: 169/255.0, green: 206/255.0, blue: 82/255.0, alpha: 1)     //



typealias YBCBtn = (UIView)->UIView

// 一等函数 也是一个闭包  CIImage = 图像配置
typealias hFilter = (CIImage) -> CIImage


// 模糊效果  高斯模糊
func hBlur(radius:Double) -> hFilter {
    return { image in
        let parameters = [kCIInputRadiusKey: radius,
                          kCIInputImageKey : image] as [String : AnyObject]
        
        guard  let filter =  CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else {fatalError()}
        
        return outputImage;
    }
}

// 柯里化 传入一个圆角，返回一个 传入view返回view的函数
func getRoundView(radiu:CGFloat)->(UIView)->UIView{
    return {view in
        view.clipsToBounds = true
        view.layer.cornerRadius = radiu
        return view
    }
}

// 柯里化 传入一个边框宽度 返回一个传入view返回view的函数
func getBorderView(borderWidth:CGFloat)->(UIView)->UIView{
    return {view in
        view.clipsToBounds = true
        view.layer.borderWidth = borderWidth
        return view
    }
}

//柯里化 传入一个边框颜色 返回一个传入view返回view的函数
func getBorderColorView(borderColor:UIColor)->(UIView)->UIView{
    return {view in
        view.clipsToBounds = true
        view.layer.borderColor = borderColor.CGColor
        return view
        
    }
}

//设置font
func hFont(size:CGFloat)->UIFont{
    return UIFont(name:hFamilyNames[0],size:size)!
}


//更新数据源
func updateDataSource(arr:NSArray)->NSMutableArray{
    let originalArr = arr
    let newArr : NSMutableArray = NSMutableArray.init(capacity: originalArr.count+4)
    newArr.addObjectsFromArray(originalArr as [AnyObject])
    
    // count =5
    //  01234
    //340123401
    //在第一个位置插入3
    newArr.insertObject(originalArr[originalArr.count-2], atIndex: 0)
    //第二个位置插入4
    newArr.insertObject(originalArr[originalArr.count-1], atIndex: 1)
    //倒数第二个位置
    newArr.addObject(originalArr[0])
    //最后一个
    newArr.addObject(originalArr[1])
    return newArr
}



