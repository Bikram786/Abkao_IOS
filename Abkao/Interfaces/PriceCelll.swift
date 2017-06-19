//
//  PriceCelll.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class PriceCelll: NSObject {
    
    //setter and getters
    public var productName: String?
    public var productRate: String?
    
    
    override init(){
        self.productName = ""
        self.productRate = ""
    }
    
    func resetData(){
        self.productName = ""
        self.productRate = ""
    }
    
    public func setProductPriceData(productInfoObj : [String : AnyObject])
    {
        
        print(productInfoObj)
        self.productName =  (productInfoObj["product_name"] as? String ?? "")
        self.productRate =  (productInfoObj["product_price"] as? String ?? "")
        
    }


}
