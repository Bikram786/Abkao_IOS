//
//  ProductPriceI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ProductPriceI: NSObject {

    
    //setter and getters
    public var productName: String?
    public var productRate: String?
    public var productID: String?
    
    
    override init()
    {
        self.productName = ""
        self.productRate = ""
        self.productID = ""
        
    }
    
    func resetData()
    {
        self.productName = ""
        self.productRate = ""
        self.productID = ""
    }
    
    public func setProductPriceData(riderObj : [String : AnyObject])
    {
        self.productName =  (riderObj["country_code"] as? String ?? "")
        self.productRate =  (riderObj["external_id"] as? String ?? "")
        self.productID =  (riderObj["first_name"] as? String ?? "")
    }

}
