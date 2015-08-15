//
//  LineCollectionViewFlowLayout.swift
//  CustomFlowLayoutDemo
//
//  Created by 张青明 on 15/8/13.
//  Copyright (c) 2015年 极客栈. All rights reserved.
//

import UIKit

let kItemWidth:CGFloat  = 250
let kItemHeight:CGFloat = 250

class LineCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    只要显示的边界发生改变就重新布局:
    内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获取所有cell的布局属性
    */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    /**
    用来设置UICollectionView停止滚动那一刻的位置
    
    :param: proposedContentOffset 原本UICollectionView停止滚动那一刻的位置
    :param: velocity              滚动速度
    */
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        // 计算出scrollView最后会停留的范围
        var lastRect:CGRect = CGRectZero
        lastRect.origin = proposedContentOffset
        lastRect.size   = self.collectionView!.frame.size
        
        // 计算屏幕最中间的x
        var centerX     = proposedContentOffset.x + self.collectionView!.frame.size.width * 0.5
        
        
        // 取出这个范围内的所有属性
        var attributesArray  = self.layoutAttributesForElementsInRect(lastRect) as! [UICollectionViewLayoutAttributes]
        
        // 遍历所有属性

        var adjustOffsetX = CGFloat.max
        for attributes in attributesArray {
            if abs(attributes.center.x - centerX) < abs(adjustOffsetX) {
                adjustOffsetX = attributes.center.x - centerX
            }
        }
        
//        if adjustOffsetX == -12.5 {
//            adjustOffsetX=0
//        }
        
        return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y)
    }
    
    
    /**
    一些初始化工作最好在这里实现
    */
    override func prepareLayout() {
        super.prepareLayout()
        
        // 设置每个cell的尺寸
        self.itemSize = CGSizeMake(kItemWidth, kItemHeight)
        var leftInset:CGFloat = (self.collectionView!.frame.size.width - kItemWidth) * 0.5
        var rightInset:CGFloat = (self.collectionView!.frame.size.height - kItemHeight) * 0.5
        self.sectionInset = UIEdgeInsetsMake(0, leftInset, 0, rightInset)
        
        // 设置水平滚动
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.minimumLineSpacing = 10
        
        
    }
    
    
    /** 有效距离:当item的中间x距离屏幕的中间x在HMActiveDistance以内,才会开始放大, 其它情况都是缩小 */
    let HMActiveDistance:CGFloat = 150;
    /** 缩放因素: 值越大, item就会越大 */
    let HMScaleFactor:CGFloat = 0.2;
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        // 计算可见的矩形框
        var visiableRect:CGRect = CGRectZero
        visiableRect.size   = self.collectionView!.frame.size
        visiableRect.origin = self.collectionView!.contentOffset
        
        
        // 取得默认的cell的UICollectionViewLayoutAttributes
        var attributesArray = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
        // 计算屏幕最中间的x
        var centerX = self.collectionView!.contentOffset.x + self.collectionView!.frame.size.width * 0.5
        
        // 遍历所有的布局属性
        for attributes in attributesArray {
            // 如果不在屏幕上，直接跳过
            if !CGRectIntersectsRect(visiableRect, attributes.frame)
            {
                continue
            }
            // 每一个item的中点x
            var itemCenterX = attributes.center.x
            
            
            // 差距越小，缩放比例越大
            // 根据 与屏幕最中间的距离计算缩放比例
            var scale:CGFloat = 1.0 + HMScaleFactor * (1 - ( abs(itemCenterX-centerX) / HMActiveDistance))
            
            attributes.transform = CGAffineTransformMakeScale(scale, scale)
            
        }
        return attributesArray
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
