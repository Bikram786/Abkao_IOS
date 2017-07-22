//
//  DiscountI.swift
//  Abkao
//
//  Created by Abhishek Singla on 23/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class DiscountI: NSObject {

    
    public var price : Float?
    public var Id: Int?
    
    override init()
    {
        self.price = 0.0
        self.Id = 0
    }
    
    public func setDiscountInfo(dictData : [String : AnyObject])
    {
        self.price =   dictData["Price"] as? Float
        self.Id = dictData["Id"] as? Int
    }
}
