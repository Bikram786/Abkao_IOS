//
//  PromotionI.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class PromotionI: NSObject {

    public var name : String?
    public var quantity: Float?
    public var price : Float?
    
    override init()
    {
        self.name = ""
        self.quantity = 0.0
        self.price = 0.0
    }
    
    public func setPromotionInfo(dictData : [String : AnyObject])
    {
        self.name =   dictData["Name"] as? String ?? ""
        self.quantity = dictData["Qty"] as? Float
        self.price =   dictData["Price"] as? Float
    }
}
