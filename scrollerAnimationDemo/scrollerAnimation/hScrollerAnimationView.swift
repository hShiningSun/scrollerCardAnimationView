//
//  hScrollerAnimationView.swift
//  HomeForPets
//
//  Created by Admin on 2016/5/22.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

import UIKit

@objc public protocol hScrollerDelegate {
    func viewForScrollerAtIndex(index:Int)->UIView
    func bgImageForCardAtIndex(index:Int)->UIImage
}

@objc public protocol hScroolerDataSource {
    func numberOfCardsInScroller()->Int
    func heightForPlanCard()->CGFloat
    func widthForPlanCard()->CGFloat
}
/**
 *  375*200     设计图 750* 400
 *  scroll top = (75/2) = 37
 *
 *
 *  scroll botomm = (20/2) = 10
 *  
 *
 * 卡片设计最大宽高  187*140        374 * 280
 */

@objc  class hScrollerAnimationView: UIView ,UIScrollViewDelegate{
    
    @objc dynamic internal var delegate : hScrollerDelegate?
    @objc dynamic internal var dataSource : hScroolerDataSource?

    @objc dynamic var isOpenUpdateLayout = true  //是否打开滚动视图
    @objc dynamic var closestMidView : UIView?

    @objc dynamic var cardArray : NSMutableArray?
    
    @objc dynamic lazy var backgroundImageView = UIImageView()
    @objc dynamic lazy var scrollView: UIScrollView = UIScrollView()
    
    var cardWidth  : CGFloat?
    var cardHeight  : CGFloat?
    
    
    var cardNumber : Int?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    //MARK:加载卡片数据
    @objc dynamic internal func loadCardData(){
        
        
        cardWidth  = self.getConstantWidth(planWidth: self.dataSource!.widthForPlanCard())
        cardHeight = self.getConstantHeight(planHeight: self.dataSource!.heightForPlanCard())
        cardNumber = self.dataSource!.numberOfCardsInScroller()+4
        cardArray = NSMutableArray.init(capacity: cardNumber!)
        
        //背景
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.image = self.delegate!.bgImageForCardAtIndex(0)
        self.setBackViewLayout()
        
        //scrollerView
        self.addSubview(scrollView)
        self.initScroll()
        self.setScrollerLayout()
        
        
        
        
        self.scrollView.contentSize = CGSize(width: cardWidth! * CGFloat.init(self.cardNumber!), height: cardHeight!)
        
        
        for i in 0...self.cardNumber!-1 {
            let card : UIView = self.createCard(i)
            self.scrollView.addSubview(card)
            self.cardArray?.addObject(card)
        }
        
        self.setOriganl(7,animation: false)
        
        
    }

    
    //MARK:初始化scroller
    func initScroll(){
        
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.pagingEnabled = false
        self.scrollView.scrollsToTop = false
        self.scrollView.clipsToBounds = false
        self.scrollView.delegate = self
    }

    
    //设置 scroller的layout
    func setScrollerLayout(){
        let scrolltop = self.getConstantHeight(planHeight: 37)
        let scrollBot = self.getConstantHeight(planHeight: 10)
        self.scrollView.addhLayout(topConstant: scrolltop, left: hInValidLayoutConstant, bottom: scrollBot, right: hInValidLayoutConstant, toView: self)
        self.scrollView.addhLayoutwidth(self.bounds.size.width)
        self.scrollView.addhLayoutCenterX(0, toView: self)
        
    }

    //MARK:设置的autolayout
    func setBackViewLayout(){
        self.backgroundImageView.addhLayout(topConstant: 0, left: 0, bottom: 0, right: 0, toView: self)
    }
    
    
    
    //创建单个卡片
    func createCard(index:Int)->UIView{
        
        
        
        let cardView : UIView = self.delegate!.viewForScrollerAtIndex(self.dataIndexForCardIndex(index))
        cardView.frame = CGRect(x: (CGFloat)(index) * cardWidth!+5,y:0,width:cardWidth!-10,height:cardHeight!)

        cardView.tag = index
        return cardView
    }
    
    func dataIndexForCardIndex(i:Int)->Int{
        var index = 0
        if i==0 {
            index =  cardNumber!-6
        }
        else if i == 1{
            index =  cardNumber!-5
        }
        else if i == 2{
            index =  0
        }
        else if i == cardNumber!-2{
            index =  0
        }
        else if i == cardNumber!-1{
            index =  1
        }
        else{
            index = i-2
        }
        return index
    }
    
    
    var isOpenSetMidCard = true//是否开启记录距离中心最近卡片
    //MARK:SCROLLER DELEGATE
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.x == 0 {
            self.setMidCard()
            self.setLoop()
        }
        else{
//            if targetContentOffset.memory.x < cardWidth!*2.5 {
//                targetContentOffset.memory = CGPoint(x: cardWidth!*(CGFloat)(2), y:targetContentOffset.memory.y)
//                isOpenSetMidCard = false
//                self.closestMidView = self.cardArray![cardNumber!-3] as? UIView
//                
//            }
//            else if targetContentOffset.memory.x > cardWidth!*(CGFloat)(cardNumber!-3){
//                targetContentOffset.memory = CGPoint(x: cardWidth!*(CGFloat)(cardNumber!-2), y:targetContentOffset.memory.y)
//                isOpenSetMidCard = false
//                self.closestMidView = self.cardArray![2] as? UIView
//            }
            
        }
        
        
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.setMidCard()
        self.setLoop()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.isOpenUpdateLayout {
        self.updateCardLayout()
        }
    }
    
    // 重置位置在中间
    func setOriganl(cardIndex:Int,animation:Bool){
        
        let scrollOffset = scrollView.contentOffset.x
        //获取卡片中间位置滚动的相对位置
        let CenterX = scrollOffset+CGRectGetWidth(self.frame)/2;
        let cardCenterX = ((self.cardArray![cardIndex]) as! UIView).center.x
        //获取卡片中间位置和俯视图中间位置的间距，目标是间距越大卡片越短
        let  apartLength = CenterX - cardCenterX
        
        self.scrollView.setContentOffset(CGPointMake(scrollOffset-apartLength, 0), animated: animation)
    }
    
    // 设置无限循环
    func setLoop(){
        //012345678
        //340123401    9
        if self.closestMidView?.tag <= 1 {
            self.setOriganl(((self.cardNumber)!-3), animation: false)
        }
        if self.closestMidView?.tag >=  (self.cardNumber)!-2{
            self.setOriganl(2, animation: false)
        }
        isOpenSetMidCard = true

    }
    
    
    //设置最中卡片
    func  setMidCard(){
        let scrollOffset = scrollView.contentOffset.x;
        
        //获取卡片中间位置滚动的相对位置
        let CenterX = scrollOffset+CGRectGetWidth(scrollView.frame)/2;
        let cardCenterX = closestMidView!.center.x
        //获取卡片中间位置和俯视图中间位置的间距，目标是间距越大卡片越短
        let  apartLength = CenterX - cardCenterX
        
        self.isOpenUpdateLayout = false
        scrollView.setContentOffset(CGPoint.init(x: scrollOffset-apartLength, y:0), animated: true)
        self.isOpenUpdateLayout = true
        
        
        self.backgroundImageView.image = self.delegate!.bgImageForCardAtIndex(self.dataIndexForCardIndex(closestMidView!.tag))
    }
    
    //MARK:更新效果
    func updateCardLayout(){
        for qcard in self.cardArray! {
            let card = qcard as! UIView
            //获取卡片所在index
            //获取ScrollView滚动的位置
            let scrollOffset = scrollView.contentOffset.x;
            //获取卡片中间位置滚动的相对位置
            let CenterX = scrollOffset+CGRectGetWidth(self.frame)/2;
            let cardCenterX = card.center.x
            //获取卡片中间位置和俯视图中间位置的间距，目标是间距越大卡片越短
            let  apartLength = fabs(CenterX - cardCenterX);
            //移动的距离和屏幕宽度的的比例
            let apartScale = 0.2/cardWidth! * apartLength ;
            //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
            let scale = 1-apartScale//fabs(cos(Double.init(apartScale) * M_PI/4));
            //设置卡片的缩放
            card.transform = CGAffineTransformMakeScale(1.0, CGFloat(scale));
            card.layoutIfNeeded()
            
            if apartLength < cardWidth!/2 && isOpenSetMidCard{
                closestMidView = card
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // 传入一个设计高  返回一个实际高
    func getConstantHeight(planHeight num:CGFloat)->CGFloat
    {
        return num/200 * self.bounds.height
    }
    
    // 一个设计宽 返回一个实际宽
    func getConstantWidth(planWidth num:CGFloat)->CGFloat
    {
        return num/375 * self.bounds.width
    }
}
