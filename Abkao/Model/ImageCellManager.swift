//
//  ImageCellManager.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class ImageCellManager: NSObject {

    func addNewRecord(userInfo: [String : Any], handler : @escaping (ImageCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "addProductImageGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let userObj = ImageCelll()
                
                //  print(userObj.userID!)
                
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }

    func updateRecord(userInfo: [String : Any], handler : @escaping (ImageCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "updateProductImageGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let userObj = ImageCelll()
                
                //  print(userObj.userID!)
                
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
    func deleteRecord(userInfo: [String : Any], handler : @escaping (ImageCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "deleteProduct", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let userObj = ImageCelll()
                
                //  print(userObj.userID!)
                
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
    func getAllRecords(userID: [String : Any], handler : @escaping (ImageCelll, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getProductInImageGrid", headers: true, params: userID, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let productObj = ImageCelll()
                productObj.setProductImageData(productInfoObj: jsonDict.value(forKey: "data") as! [String : AnyObject])
                handler(productObj,true,"Products Received")
                
                //userObj.userID = jsonDict.value(forKey: "userid") as? Int
                
                //  print(userObj.userID!)
                
                //handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
}
