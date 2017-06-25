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
    public var productVedUrl: String?
    public var productID: Int?
    
    override init()
    {
        self.productVedUrl = ""
        self.productName = ""
        self.productImgUrl = ""
        self.productPrice = ""
        self.productID = 0
    }
    
    func resetData()
    {
        self.productVedUrl = ""
        self.productName = ""
        self.productImgUrl = ""
        self.productPrice = ""
        self.productID = 0
    }
    
    public func setProductDescData(productInfoObj : [String : AnyObject])
    {
        print(productInfoObj)
        
        
//        let escapedString = (productInfoObj["product_url"] as? String ?? "")
//        let strUrl = escapedString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)

        self.productName =  (productInfoObj["product_name"] as? String ?? "")
        self.productImgUrl =  (productInfoObj["product_url"] as? String ?? "")
        self.productVedUrl = (productInfoObj["product_video_url"] as? String ?? "")
        self.productPrice =  (productInfoObj["product_price"] as? String ?? "")
        self.productID =  (productInfoObj["product_id"] as? Int)
    }
    
}

