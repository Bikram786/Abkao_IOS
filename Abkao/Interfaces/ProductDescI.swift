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
    public var productPrice: String?
    public var productID: Int?
    
    override init()
    {
        self.productName = ""
        self.productImgUrl = ""
        self.productPrice = ""
        self.productID = 0
    }
    
    func resetData()
    {
        self.productName = ""
        self.productImgUrl = ""
        self.productPrice = ""
        self.productID = 0
    }
    
    public func setProductDescData(productInfoObj : [String : AnyObject])
    {
        print(productInfoObj)
        
        self.productName =  (productInfoObj["product_name"] as? String ?? "")
        //self.productImgUrl =  (productInfoObj["country_code"] as? String ?? "")
        self.productPrice =  (productInfoObj["product_price"] as? String ?? "")
        self.productID =  (productInfoObj["product_id"] as? Int)
    }
    
}

