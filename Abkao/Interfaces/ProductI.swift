//
//  ProductI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ProductI: NSObject {

    //setter and getters
    public var productVedUrl: String?
    public var arrProductDesc : [ProductDescI]?
    public var arrProductPrice : [ProductPriceI]?
    public var imageGridRowValue: Int?
    public var priceGridRowValue: Int?
    
    override init() {
        
        self.productVedUrl = ""
        self.arrProductDesc = [ProductDescI]()
        self.arrProductPrice = [ProductPriceI]()
        self.imageGridRowValue = 0
        self.priceGridRowValue = 0

    }
    
    func resetData()
    {
        self.productVedUrl = ""
        self.arrProductDesc?.removeAll()
        self.arrProductPrice?.removeAll()
        self.imageGridRowValue = 0
        self.priceGridRowValue = 0

    }
    
    public func setProductsData(productObj : [String : AnyObject])
    {
        
        print("Product data : \(productObj)")
        
        if let tempObj = productObj["image_grid"] as? NSArray
        {
            for productInfo in tempObj
            {
                let product  = productInfo  as! [String : AnyObject]
                
                let productDesc = ProductDescI()
                
                productDesc.setProductDescData(productInfoObj: product)

                self.arrProductDesc?.append(productDesc)
                
            }
            
        }
        
        
        if let tempObj = productObj["price_grid"] as? NSArray
        {
            for priceInfo in tempObj
            {
                let price  = priceInfo  as! [String : AnyObject]
                
                let priceDesc = ProductPriceI()
                
                priceDesc.setProductPriceData(priceObjInfo: price)
                
                self.arrProductPrice?.append(priceDesc)
            }
            
        }
        
        self.productVedUrl =  (productObj["video_url"] as? String ?? "")
        self.imageGridRowValue = Int((productObj["image_grid_row"] as? String)!)
        self.priceGridRowValue = Int((productObj["price_grid_dimension"] as? String)!)
        
    }
    
}
