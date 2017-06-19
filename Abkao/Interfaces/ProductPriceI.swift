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
    public var productID: Int?
    
    
    override init(){
        self.productName = ""
        self.productRate = ""
        self.productID = 0
    }
    
    func resetData(){
        self.productName = ""
        self.productRate = ""
        self.productID = 0
    }
    
    public func setProductPriceData(productInfoObj : [String : AnyObject])
    {
        self.productName =  (productInfoObj["product_name"] as? String ?? "")
        //self.productImgUrl =  (productInfoObj["country_code"] as? String ?? "")
        self.productRate =  (productInfoObj["product_price"] as? String ?? "")
        self.productID =  (productInfoObj["product_id"] as? Int)
    }

}
