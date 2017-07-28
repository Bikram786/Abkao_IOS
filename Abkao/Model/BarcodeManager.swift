//
//  BarcodeManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class BarcodeManager: NSObject {
    
    var barCodeValue : String?
    var isBarcodeDetailsOpen : Bool?

    
    func scanBarcode(barcodeDict: [String : Any], handler : @escaping (BarcodeI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "barcode", headers: true, params: barcodeDict, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                if(jsonDict.value(forKey: "success") as! Bool)
                {
                    let barcodeObj = BarcodeI()
                    barcodeObj.setProductPriceData(productInfoObj: jsonDict as! [String : AnyObject])
                    handler(barcodeObj , true ,"Response sucessfully")
                
                }else{
                
                    handler(nil , false ,"Product information not available")
                }
        })
    }
    
   
    
}
