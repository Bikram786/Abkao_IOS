//
//  BarcodeI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class BarcodeI: NSObject {

    //setter and getters
    
    public var productName: String?
    public var productLocation: String?
    public var productPromotionText: String?
    //public var productID: Int?
    public var productPromotionPrice: String?
    
    
    override init(){
        
        self.productName = ""
        self.productLocation = ""
        self.productPromotionText = ""
        //self.productID = 0
        self.productPromotionPrice = ""
    }
    
    func resetData(){
        
        self.productName = ""
        self.productLocation = ""
        self.productPromotionText = ""
        //self.productID = 0
        self.productPromotionPrice = ""
    }
    
    public func setProductPriceData(productInfoObj : [String : AnyObject])
    {
        //self.productID = productInfoObj["Id"] as? Int
        self.productName = (productInfoObj["ItemName"] as? String ?? "")
        self.productLocation = (productInfoObj["LocationName"] as? String ?? "")
        self.productPromotionText = (productInfoObj["Promotiontext"] as? String ?? "")
        self.productPromotionPrice = (productInfoObj["Price"] as? String ?? "")
        
    }

}
