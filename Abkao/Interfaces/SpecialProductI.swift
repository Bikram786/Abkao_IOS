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
    
    override init()
    {
        self.name = ""
    }
    
    public func setProductName(dictData : [String : AnyObject])
    {
        self.name =   dictData["RecordName"] as? String ?? ""
    }
}
