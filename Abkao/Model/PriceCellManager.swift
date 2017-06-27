//
//  PriceCellManager.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class PriceCellManager: NSObject {

    var arrProductPrice : [ProductPriceI]?
    
    override init()
    {
        arrProductPrice = [ProductPriceI]()
    }
    
    func addNewRecord(userInfo: [String : Any], handler : @escaping (ProductPriceI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "addProductPriceGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        let productPriceObj = ProductPriceI()
                        productPriceObj.setProductPriceData(productInfoObj: jsonDict as! [String : AnyObject])
                        handler(productPriceObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                        
                    }else{
                        handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                }
               
                
                
        })
    }
    
    func updateRecord(userInfo: [String : Any], handler : @escaping (ProductPriceI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "updateProductPriceGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess)                    {
                        let productPriceObj = ProductPriceI()
                        handler(productPriceObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                        

                    }else{
                        handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                }
                
                
        })
    }
    
    func deleteRecord(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "deleteProduct", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        
                        handler(true,(jsonDict.value(forKey: "message") as? String)!)
                        
                    }else{
                        
                        handler(false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
                
        })
    }
    
    func getAllRecords(userID: [String : Any], handler : @escaping ([ProductPriceI]?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getProductInPriceGrid", headers: true, params: userID, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                if(statusCode == 200)
                {
                    let data = jsonDict.value(forKey: "data") as! NSDictionary
                    let isSuccess = data["success"] as! Bool
                    if(isSuccess)
                    {
                        
                       var productInfoObj : [String : AnyObject] = jsonDict.value(forKey: "data") as! [String : AnyObject]
                        
                        let arrData = productInfoObj["price_grid"] as! NSArray
                        if(arrData.count > 0)
                        {
                            self.arrProductPrice?.removeAll()
                            
                            for dictObj in arrData
                            {
                                let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                                
                                let productObj = ProductPriceI()
                                productObj.setProductPriceData(productInfoObj: tempProductInfoObj)
                                
                                self.arrProductPrice?.append(productObj)
                                
                            }
                        }
                        
                        handler(self.arrProductPrice,true,"Products Received")
                        
                    }else{
                        handler(nil,false,"Products Received")
                    }
                }else{
                    handler(nil,false,"Products Received")
                }
                
        })
    }
}
