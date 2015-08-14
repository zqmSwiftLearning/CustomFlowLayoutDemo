//
//  CatModel.swift
//  CustomFlowLayoutDemo
//
//  Created by 张青明 on 15/8/13.
//  Copyright (c) 2015年 极客栈. All rights reserved.
//

import UIKit

/// 猫咪存钱罐数据模型
class CatModel: NSObject, DebugPrintable, Printable {
    
    /// 猫名字
    var catName:String    = ""
    /// 猫图片
    var catImage:String   = ""
    /// 存款容量
    var capacity:String   = ""
    /// 积分兑换价
    var integral:String   = ""
    /// mm兑换价
    var conversion:String = ""
    /// 完成储蓄奖励
    var award:String      = ""
    
    override init() {
        super.init()
    }
    
    init(catName:String, catImage:String, capacity:String, integral:String, conversion:String, award:String) {
        super.init()
        
        self.catName    = catName
        self.catImage   = catImage
        self.capacity   = capacity
        self.integral   = integral
        self.conversion = conversion
        self.award      = award
    }
    
    class func arrayFromPlist() -> NSArray {
        var catInfos = [CatModel]()
        var array:NSArray = NSArray()
        var plistPath = NSBundle.mainBundle().pathForResource("Cat", ofType: "plist")
        if let path = plistPath
        {
            if let list = NSArray(contentsOfFile: path)
            {
                for item in list {
                    
                    #if false
                        
                    var model = CatModel(catName: item["catName"] as! String, catImage: item["catImage"] as! String, capacity: item["capacity"] as! String, integral: item["integral"] as! String, conversion: item["conversion"] as! String, award: item["award"] as! String)
                    
                    var names = item as! [String:String]
                    var keys  = sorted(item.allKeys as! [String])
                
                    var catName = names["catName"]
                    print("names:\(catName)\n\n\n")
                    print("keys :\(keys)\n")
                    
                    catInfos.append(model)
                        
                    #elseif false
                        
                    var model1 = CatModel()
                    var names = item as! [String:String]
                    var keys  = sorted(item.allKeys as! [String])
                    for key in keys {
                        model1.setValue(names[key], forKey: key)
                    }
                    catInfos.append(model1)
                
                    #else
                        
                    var model2 = CatModel()
                    for (key, value) in item as! [String:String] {
                        model2.setValue(value, forKey: key)
                    }
                    catInfos.append(model2)
                
                    #endif
                }
            }

        }
        
        return catInfos
    }

    //类实例的描述信息
//    override var description: String {
//        //TODO:自定义需要返回的描述信息内容
////        var descString = CatModel.Type
////        self.
//        return "<\(self.dynamicType):, catName:\(self.catName) >\n"
//    }
    
    override var description: String {
        get{
            return "\(super.description), catName:\(self.catName), catImage:\(self.catImage), capacity:\(self.capacity), integral:\(self.integral),conversion:\(self.conversion), award:\(self.award)\n"
        }
    }
    
    override var debugDescription:String {
        return "Hello"
    }
}

