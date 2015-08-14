//
//  CatCollectionViewCell.swift
//  CustomFlowLayoutDemo
//
//  Created by 张青明 on 15/8/13.
//  Copyright (c) 2015年 极客栈. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    var model = CatModel(){
        didSet {
            self.ivCat.image        = UIImage(named: model.catImage)
            self.lblCatName.text    = model.catName
            self.lblCapacity.text   = model.capacity
            self.lblIntegral.text   = model.integral
            self.lblConversion.text = model.conversion
            self.lblAward.text      = model.award
        }
    }

    /// 存钱罐详细信息
    @IBOutlet weak var vLabelContainer: UIView!
    /// 按钮
    @IBOutlet weak var btnSelected: UIButton!
    /**
    把cell进行翻转
    */
    @IBAction func turnCellOvew(sender: UIButton) {
        self.isHideContainer = !self.isHideContainer
        UIView.transitionWithView(self, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
            
            }) { (finished:Bool) -> Void in
                
        }
    }
    
    
    /// 猫图片
    @IBOutlet weak var ivCat: UIImageView!
    /// 猫名字
    @IBOutlet weak var lblCatName: UILabel!
    /// 存款容量
    @IBOutlet weak var lblCapacity: UILabel!
    /// 积分兑换价
    @IBOutlet weak var lblIntegral: UILabel!
    /// mm兑换价
    @IBOutlet weak var lblConversion: UILabel!
    /// 完成储蓄奖励
    @IBOutlet weak var lblAward: UILabel!
    
    
    
    var isHideContainer:Bool = true {
        didSet {
            vLabelContainer.hidden = isHideContainer
            btnSelected.selected   = !isHideContainer
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.autoresizingMask = UIViewAutoresizing.None
    }
    
    class func collectionView(collectionView:UICollectionView, indexPath:NSIndexPath, identifier:String, catModel:CatModel?)->CatCollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseID, forIndexPath: indexPath) as! CatCollectionViewCell
        cell.isHideContainer = true
        
        if let catM = catModel {
            cell.model = catM
        }
        
        return cell
    }

    
    class func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CatCollectionViewCell
        cell.isHideContainer = !cell.isHideContainer
        UIView.transitionWithView(cell, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
            
            }) { (finished:Bool) -> Void in
                
        }
    }
}
