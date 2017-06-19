//
//  ImageCelll.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class ImageCelll: NSObject {

    //setter and getters
    public var arrProductImage : [ProductDescI]?
    public var productName: String?
    public var productRate: String?
    public var productID: Int?
    
    override init(){
        self.arrProductImage = [ProductDescI]()
        self.productName = ""
        self.productRate = ""
        self.productID = 0
    }
    
    func resetData(){
        self.arrProductImage = [ProductDescI]()
        self.productName = ""
        self.productRate = ""
        self.productID = 0
    }
    
    public func setProductImageData(productInfoObj : [String : AnyObject])
    {
        
        print(productInfoObj)
        
        if let tempObj = productInfoObj["image_grid"] as? NSArray
        {
            for priceInfo in tempObj
            {
                let price  = priceInfo  as! [String : AnyObject]
                
                let priceDesc = ProductDescI()
                
                priceDesc.setProductDescData(productInfoObj: price)
                
                self.arrProductImage?.append(priceDesc)
                
                print(self.arrProductImage!)
            }
            
        }
        
    }

}
