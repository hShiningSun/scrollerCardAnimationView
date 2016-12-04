//
//  self.swift
//  HomeForPets
//
//  Created by Admin on 2016/5/23.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

import UIKit

class CardView: UIView {
    
   
    
    var topImage : UIImageView?
    var titleLabel:UILabel?
    var assistantTitleLabel:UILabel?
    var iconImg : UIImageView?
    var attentionBtn : UIButton?
    var alphaView:UIView?
    
    var model : NSDictionary?

    override init(frame:CGRect) {
        super.init(frame: frame)
        
        
        let cardWidth:CGFloat = frame.size.width,cardHeight:CGFloat = frame.size.height
        let contentView = UIView(frame:self.bounds)
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.whiteColor().CGColor
        contentView.layer.borderWidth = 1
        
        self.addSubview(contentView)
        
        // 上半部分背景
        topImage = UIImageView()
        topImage?.contentMode = .ScaleAspectFill
        topImage?.clipsToBounds = true
        topImage!.backgroundColor = UIColor.greenColor()
        contentView.addSubview(topImage!)
        topImage!.addhLayout(topConstant: 0, left: 0, bottom: hInValidLayoutConstant, right: 0, toView: contentView)
        topImage!.addhLayoutheight(cardHeight/2)
        
        // 下半部分 创建一个主要标题
        titleLabel = UILabel()
        contentView.addSubview(titleLabel!)
        
        titleLabel!.addhLayoutCenterX(0, toView: contentView)
        titleLabel!.addhLayoutCenterY(30, toView: contentView)//第一个值正向偏移
        titleLabel!.text = "测试主标题"
        titleLabel!.font = hFont(12)
        titleLabel?.textAlignment = .Center
        titleLabel!.textColor = titleColor
        
        // 副标题
        assistantTitleLabel = UILabel()
        contentView.addSubview(assistantTitleLabel!)
        
        assistantTitleLabel!.addhLayout(topConstant: 5, left: hInValidLayoutConstant, bottom: hInValidLayoutConstant, right: hInValidLayoutConstant, toView: titleLabel!)
        assistantTitleLabel!.addhLayoutCenterX(0, toView: contentView)
        assistantTitleLabel!.addhLayoutwidth(cardWidth)
        assistantTitleLabel!.addhLayoutheight(15)
        
        assistantTitleLabel!.text = "测试副标题"
        assistantTitleLabel?.textAlignment = .Center
        assistantTitleLabel!.font = hFont(10)
        assistantTitleLabel!.textColor = h_MID_GAY
        
//        //alphaView
//        alphaView = UIView(frame:self.bounds)
//        alphaView?.backgroundColor = UIColor.clearColor()
//        contentView.addSubview(alphaView!)
        
        // icon
        iconImg = UIImageView()//38  38
        contentView.addSubview(iconImg!)
        
        iconImg!.addhLayoutCenterY(-10, toView: contentView)
        iconImg!.addhLayoutCenterX(0, toView: contentView)
        iconImg!.addhLayoutwidth(38)
        iconImg!.addhLayoutheight(38)
        
        iconImg = getRoundView(19)(iconImg!) as? UIImageView
        iconImg = getBorderView(1)(iconImg!) as? UIImageView
        iconImg = getBorderColorView(UIColor.whiteColor())(iconImg!) as? UIImageView
        iconImg!.backgroundColor = UIColor.blueColor()
        
        
        //关注
        attentionBtn = UIButton()
        self.addSubview(attentionBtn!)
        
        attentionBtn = getRoundView(9)(attentionBtn!) as? UIButton
        attentionBtn = getBorderView(1)(attentionBtn!) as? UIButton
        attentionBtn = getBorderColorView(h_ORIGIN)(attentionBtn!) as? UIButton
        attentionBtn?.setTitle("+关注", forState: .Normal)
        attentionBtn?.setTitleColor(h_ORIGIN, forState: .Normal)
        attentionBtn?.titleLabel?.font = hFont(12)
        attentionBtn?.backgroundColor = UIColor.whiteColor()
        
        attentionBtn?.addhLayoutCenterX(0, toView: self)
        attentionBtn?.addhLayoutCenterY(cardHeight/2, toView: self)
        attentionBtn?.addhLayoutheight(18)
        attentionBtn?.addhLayoutwidth(50)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setData(obj:AnyObject){
        
        
            //self.model = obj as? NSDictionary

            self.topImage?.image = UIImage(named: "icon1.jpg")//sd_setImageWithURL(NSURL.init(string: self.model!["icon"]! as! String), check: false)
            self.iconImg?.image = UIImage(named: "icon2.jpg")//sd_setImageWithURL(NSURL.init(string: self.model!["icon"]! as! String), check: false)
        
    
            //频道标题
            self.titleLabel?.text = "频道"+(obj as! String)//self.model!["title"]! as? String
            //副标题
            self.assistantTitleLabel?.text = "副标题"//self.model!["description"]! as? String
            //关注情况
            self.updateAttentionState()
            //子视图
            self.refreshSubContainers()
        
    }

    func updateAttentionState(){
        let flagsSt = "99"//"\(self.model?.objectForKey("flags"))"
        let isCollect = "1"//"\(self.model?.objectForKey("isCollect"))"
       
        if ((Int)(flagsSt) == 99)  || ((Int)(isCollect) == 1){
            self.attentionBtn?.setTitle("已关注", forState: .Normal)
            self.attentionBtn?.setTitleColor(h_MID_GAY, forState: .Normal)
            self.attentionBtn?.layer.borderColor = h_MID_GAY.CGColor
            
            //[self.btnAttention setTitle:@"已关注" forState:UIControlStateNormal];
        }else
        {
            //未关注
            self.attentionBtn?.setTitle("+关注", forState: .Normal)
            self.attentionBtn?.setTitleColor(h_ORIGIN, forState: .Normal)
            self.attentionBtn?.layer.borderColor = h_ORIGIN.CGColor
        }
    
    }
    
    func refreshSubContainers(){
        
    }
}
