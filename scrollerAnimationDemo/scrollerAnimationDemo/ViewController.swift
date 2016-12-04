//
//  ViewController.swift
//  scrollerAnimationDemo
//
//  Created by Admin on 2016/12/4.
//  Copyright © 2016年 asd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,hScrollerDelegate,hScroolerDataSource {

    lazy var dataArray =  ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testScrollerView:hScrollerAnimationView = hScrollerAnimationView.init(frame: CGRectMake(0, 0, h_Screen_Bounds.width, 250))
        testScrollerView.delegate = self
        testScrollerView.dataSource = self
        
        self.view.addSubview(testScrollerView)
        
        testScrollerView.loadCardData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //delegate
    func viewForScrollerAtIndex(index: Int) -> UIView {
        
        // 构造你的自定义卡片，这里是我自定义的卡片
        let cardView = CardView.init(frame: CGRectMake(0, 0, 187, 140))
        let obj = self.dataArray[index]
        //要赋值就在这里处理
        cardView.setData(obj)
        return cardView
    }
    
    func bgImageForCardAtIndex(index: Int) -> UIImage {
        
        //我这里测试写死了，根据需要index来取你需要图片返回
        return UIImage(named: "icon1.jpg")!
    }
    
    //dataSource
    func numberOfCardsInScroller() -> Int {
        return self.dataArray.count
    }
    
    
    //卡片的设计宽度  和高度
    func heightForPlanCard() -> CGFloat {
        return 140
    }
    
    
    func widthForPlanCard() -> CGFloat {
        return 187
    }
}

