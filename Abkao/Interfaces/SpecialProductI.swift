//
//  SpecialProductI.swift
//  Abkao
//
//  Created by Abhishek Singla on 23/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class SpecialProductI: NSObject {

    public var name : String?
    public var price : Float?
    
    override init()
    {
        self.name = ""
        self.price = 0.0
    }
    
    public func setSpecialProductInfo(dictData : [String : AnyObject])
    {
        self.name =   dictData["Name"] as? String ?? ""
        self.price =   dictData["Price"] as? Float
    }
}
