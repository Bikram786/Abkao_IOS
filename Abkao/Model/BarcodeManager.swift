//
//  BarcodeManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class BarcodeManager: NSObject {
    
    func scanBarcode(barcodeURL: String, handler : @escaping (BarcodeI, Bool , String) -> Void)
    {
        BaseWebAccessLayer.getRequestURLWithDictionaryResponse(requestType: .post, strURL: barcodeURL, headers: true, params: nil, result:
            {
                (jsonDict,statusCode) in
                // success code                
                let data = self.convertToDictionary(text: jsonDict )
                let userObj = BarcodeI()
                userObj.setProductPriceData(productInfoObj: data! as [String : AnyObject])
                handler(userObj , true ,"Response sucessfully")
                
                
        })
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
