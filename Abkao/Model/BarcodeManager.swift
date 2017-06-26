//
//  BarcodeManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class BarcodeManager: NSObject {

    var barcodeObj : BarcodeI?
        
    override init()
    {
        barcodeObj  = BarcodeI()
    }
    
    func scanBarcode(handler : @escaping (BarcodeI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.getRequestURLWithDictionaryResponse(requestType: .post, strURL: "93027,000002820000384", headers: true, params: nil, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                if(statusCode == 200)
                {
                    let data = self.convertToDictionary(text: jsonDict )
                    self.barcodeObj?.setProductPriceData(productInfoObj: data! as [String : AnyObject])
                    handler(self.barcodeObj , true ,"Response sucessfully")
                    
                }
                else
                {
                    handler(nil , false ,"Response fail")

                }
                
                
                
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
