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
    public var recordName : String?
    public var skuNo : String?
    
    override init()
    {
        self.price = 0.0
        self.Id = 0
        self.recordName = ""
        self.skuNo = ""
    }
    
    public func setDiscountInfo(dictData : [String : AnyObject])
    {
        self.price =   dictData["Price"] as? Float
        self.Id = dictData["Id"] as? Int
        self.recordName = dictData["RecordName"] as? String ?? ""
        self.skuNo = dictData["SKU"] as? String ?? ""

    }
}
