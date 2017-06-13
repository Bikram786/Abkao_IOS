//
//  ProductDescI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ProductDescI: NSObject {

    
    //setter and getters
    public var productName: String?
    public var productImgUrl: String?
    public var productRate: String?
    public var productID: String?

    
    override init()
    {
        self.productName = ""
        self.productImgUrl = ""
        self.productRate = ""
        self.productID = ""
    }
    
    func resetData()
    {
        self.productName = ""
        self.productImgUrl = ""
        self.productRate = ""
        self.productID = ""
    }
    
    public func setProductDescData(riderObj : [String : AnyObject])
    {
        self.productName =  (riderObj["country_code"] as? String ?? "")
        self.productImgUrl =  (riderObj["country_code"] as? String ?? "")
        self.productRate =  (riderObj["external_id"] as? String ?? "")
        self.productID =  (riderObj["first_name"] as? String ?? "")
    }
    
}

