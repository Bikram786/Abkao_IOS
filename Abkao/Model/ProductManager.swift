//
//  ProductManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ProductManager: NSObject {

    func getAllProducts(userID: [String : Any], handler : @escaping (ProductI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getProductByUserid", headers: true, params: userID, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200){
                    
                    let data = jsonDict.value(forKey: "data") as! NSDictionary
                    let isSuccess = data["success"] as! Bool
                    
                    if((isSuccess)){
                        
                        let productObj = ProductI()
                        productObj.setProductsData(productObj: jsonDict.value(forKey: "data") as! [String : AnyObject])
                        handler(productObj,true,"Products Received")
                        
                    }else{
                        
                        handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                }
               
                
                
        })
    }
    
}
