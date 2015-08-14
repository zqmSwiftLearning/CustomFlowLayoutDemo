//
//  ViewController.swift
//  CustomFlowLayoutDemo
//
//  Created by 张青明 on 15/8/13.
//  Copyright (c) 2015年 极客栈. All rights reserved.
//

import UIKit

 let kCellReuseID = "CatCollectionViewCell"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var catInfos:NSArray = [CatModel]()

    
    var collectionView:UICollectionView!
    
    var pageControl:UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupView()
        self.setupData()
        
    }
    
    
    func setupData() {
        
        catInfos = CatModel.arrayFromPlist()
        self.collectionView.reloadData()
        
        print("=========\n\n")
        for model in catInfos {
            print("\(model)\n\n")
        }
        print("=========\n\n")
        
    }
    
    func setupView() {
        
        var bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image = UIImage(named: "bg")
        self.view.addSubview(bgImageView)
        
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 40, UIScreen.mainScreen().bounds.size.width, 400), collectionViewLayout: LineCollectionViewFlowLayout())
        self.collectionView.registerNib(UINib(nibName: "CatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCellReuseID)
        self.collectionView.backgroundColor = UIColor.clearColor()
//        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate  = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        
        
        self.pageControl = UIPageControl(frame: CGRectMake(0, 0, 100, 30))
        var centerX      = self.view.frame.size.width/2
        var centerY      = self.collectionView.frame.origin.y + self.collectionView.frame.size.height
        self.pageControl.center = CGPointMake(centerX, centerY)
        self.pageControl.numberOfPages = 0
        self.pageControl.userInteractionEnabled = false
        self.view.addSubview(self.pageControl)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        self.pageControl.numberOfPages = catInfos.count
        return catInfos.count
    }
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
    #if false
            
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseID, forIndexPath: indexPath) as! CatCollectionViewCell
        cell.isHideContainer = true
        return cell
            
    #else
        
        return CatCollectionViewCell.collectionView(collectionView, indexPath: indexPath, identifier: kCellReuseID, catModel: catInfos[indexPath.item] as? CatModel)
    #endif
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    #if true
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CatCollectionViewCell
        cell.isHideContainer = !cell.isHideContainer
        UIView.transitionWithView(cell, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
            
            }) { (finished:Bool) -> Void in
            
        }
            
    #else
        CatCollectionViewCell.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
    #endif
    }
}

