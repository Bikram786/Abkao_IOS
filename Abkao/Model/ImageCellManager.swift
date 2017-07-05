//
//  ImageCellManager.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class ImageCellManager: NSObject {

    var arrProductImageGrid : [ProductDescI]?
    
    override init()
    {
        arrProductImageGrid = [ProductDescI]()
    }
    
    
    func addNewRecord(userInfo: [String : Any], handler : @escaping (ProductDescI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "addProductImageGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        
                        self.updateHomeControlModalData()


                        let productDescObj = ProductDescI()
                        handler(productDescObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                        
                    }else{
                         handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                     handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                }
                
        })
    }

    func updateRecord(userInfo: [String : Any], handler : @escaping (ProductDescI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "updateProductImageGrid", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
               print(jsonDict)
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        
                        self.updateHomeControlModalData()

                        let productDescObj = ProductDescI()
                        productDescObj.setProductDescData(productInfoObj: jsonDict as! [String : AnyObject])
                        
                        handler(productDescObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                        
                    }else{
                        handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                }
               
                
        })
    }
    
    func deleteRecord(userInfo: [String : Any], handler : @escaping (ProductDescI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "deleteProduct", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        
                        self.updateHomeControlModalData()
                        
                        let productDescObj = ProductDescI()
                         handler(productDescObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                        
                    }else{
                        
                         handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                     handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                }
                
        })
    }
    
    func getAllRecords(userID: [String : Any], handler : @escaping ([ProductDescI]?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getProductInImageGrid", headers: true, params: userID, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200){
                   
                    let data = jsonDict.value(forKey: "data") as! NSDictionary
                    let isSuccess = data["success"] as! Bool
                    if(isSuccess){
                        
                        
                        var productInfoObj : [String : AnyObject] = jsonDict.value(forKey: "data") as! [String : AnyObject]
                        
                        self.arrProductImageGrid?.removeAll()
                        
                        let arrData = productInfoObj["image_grid"] as! NSArray
                        
                        if(arrData.count > 0)
                        {
                            for dictObj in arrData
                            {
                                let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                                
                                let productObj = ProductDescI()
                                productObj.setProductDescData(productInfoObj: tempProductInfoObj)
                                
                                self.arrProductImageGrid?.append(productObj)                                
                            }
                        }

                        handler(self.arrProductImageGrid,true,"Products Received")
                        
                    }else{
                        
                       handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
               
                
        })
    }
    
    func updateHomeControlModalData()
    {
        let userinfo : [String : Any] = ["userID":ModelManager.sharedInstance.profileManager.userObj?.userID as Any]
        
        ModelManager.sharedInstance.productManager.getAllProducts(userID: userinfo, handler: { (proObj, isSuccess, strMessage) in
            
        })
    }
    
}
