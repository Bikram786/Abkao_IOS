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
    public var productRate: String?
    public var productLocation: String?
    public var productPromotionText: String?
    public var productID: Int?
    
    
    
    override init(){
        
        self.productName = ""
        self.productRate = ""
        self.productLocation = ""
        self.productPromotionText = ""
        self.productID = 0
    }
    
    func resetData(){
        
        self.productName = ""
        self.productRate = ""
        self.productLocation = ""
        self.productPromotionText = ""
        self.productID = 0
    }
    
    public func setProductPriceData(productInfoObj : [String : AnyObject])
    {
        
        self.productID = productInfoObj["Id"] as? Int
        self.productName = (productInfoObj["ItemName"] as? String ?? "")
        self.productRate = (productInfoObj["Price"] as? String ?? "")
        self.productLocation = (productInfoObj["LocationName"] as? String ?? "")
        self.productPromotionText = (productInfoObj["LocationName"] as? String ?? "")
        
    }

}
