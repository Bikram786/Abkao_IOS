//
//  PriceCellManager.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class PriceCellManager: NSObject {

    
    func addNewRecord(userInfo: [String : Any], handler : @escaping (PriceCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "addProductPriceGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                let userObj = PriceCelll()
                userObj.setProductPriceData(productInfoObj: jsonDict as! [String : AnyObject])
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
    func updateRecord(userInfo: [String : Any], handler : @escaping (PriceCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "updateProductPriceGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let userObj = PriceCelll()
                
                //  print(userObj.userID!)
                
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
    func deleteRecord(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "deleteProduct", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                
                handler( true ,"Product deleted successfully")
                
        })
    }
    
    func getAllRecords(userID: [String : Any], handler : @escaping (PriceCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getProductInPriceGrid", headers: true, params: userID, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let productObj = PriceCelll()
                productObj.setProductPriceData(productInfoObj: jsonDict.value(forKey: "data") as! [String : AnyObject])
                
                handler(productObj,true,"Products Received")
               
                
        })
    }
}
