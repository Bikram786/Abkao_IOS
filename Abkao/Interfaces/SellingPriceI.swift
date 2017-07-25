//
//  SellingPriceI.swift
//  Abkao
//
//  Created by Abhishek Singla on 25/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class SellingPriceI: NSObject {

    public var strSuggestedRetail : Float?
    public var strLastPurcahsePrice : Float?
    public var strLastPurchaseDate : String?
    public var strLastPurchaseVendor : String?

    
    override init()
    {
        self.strSuggestedRetail = 0.0
        self.strLastPurcahsePrice = 0.0
        self.strLastPurchaseDate = ""
        self.strLastPurchaseVendor = ""
        
    }
    
    public func setSellingPrice(dictData : [String : AnyObject])
    {
        self.strSuggestedRetail =   dictData["SuggestedRetailPrice"] as? Float
        self.strLastPurcahsePrice =   dictData["LastPurchasePrice"] as? Float
        self.strLastPurchaseDate =   dictData["LastPurchaseDate"] as? String ?? ""
        self.strLastPurchaseVendor =   dictData["LastPurchaseVendorName"] as? String ?? ""
    }

}
