//
//  SettingsManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 10/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class SettingsManager: NSObject {

    
    func getCurrentSetting(userInfo: [String : Any], handler : @escaping (Settingsl, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "setting", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let userObj = Settingsl()
                
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
    func updateSetting(userInfo: [String : Any], handler : @escaping (Settingsl, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "setting", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                let userObj = Settingsl()
                
                handler(userObj , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
}
