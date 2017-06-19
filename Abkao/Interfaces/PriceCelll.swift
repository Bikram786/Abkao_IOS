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
    public var arrProductPrice : [ProductPriceI]?
    public var productName: String?
    public var productRate: String?
    public var productID: Int?
    
    
    override init(){
        self.arrProductPrice = [ProductPriceI]()
        self.productName = ""
        self.productRate = ""
        self.productID = 0
    }
    
    func resetData(){
        self.arrProductPrice = [ProductPriceI]()
        self.productName = ""
        self.productRate = ""
        self.productID = 0
    }
    
    public func setProductPriceData(productInfoObj : [String : AnyObject])
    {
        
        if let tempObj = productInfoObj["price_grid"] as? NSArray
        {
            for priceInfo in tempObj
            {
                let price  = priceInfo  as! [String : AnyObject]
                
                let priceDesc = ProductPriceI()
                
                priceDesc.setProductPriceData(productInfoObj: price)
                
                self.arrProductPrice?.append(priceDesc)
            }
            
        }

    }

}
