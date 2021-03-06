//
//  SettingsManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 10/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class SettingsManager: NSObject {

    var settingObj : Settingsl?
    
    override init()
    {
        settingObj  = Settingsl()
    }
    
    
    func updateSetting(userInfo: [String : Any], handler : @escaping (Settingsl?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "setting", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess){
                        
                        self.settingObj?.imageGridRow = Int((jsonDict["image_grid_row"] as? String)!)
                        self.settingObj?.priceGridDimention = Int((jsonDict["price_grid_dimension"] as? String)!)
                        self.settingObj?.videoURL = (jsonDict["video_url"] as? String ?? "")
                        self.settingObj?.backGroundColor = (jsonDict["backgroundColor"] as? String ?? "")
                        
                        ModelManager.sharedInstance.profileManager.userObj?.accountNo = (jsonDict["account_number"] as? String ?? "")
                        
                        
                        //-------------Update Modal for Home screen data
                        let userinfo : [String : Any] = ["userID":ModelManager.sharedInstance.profileManager.userObj?.userID as Any]
                        
                        
                        //save Settings Obj in defaults
                        let encodedSettings = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.settingsManager.settingObj!)
                        let userDefaults: UserDefaults = UserDefaults.standard
                        userDefaults.set(encodedSettings, forKey: "currentsetting")                        
                        userDefaults.synchronize()
                        
                        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.profileManager.userObj!)
                        userDefaults.set(encodedUser, forKey: "userinfo")
                        
                        userDefaults.synchronize()

                        
                        ModelManager.sharedInstance.productManager.getAllProducts(userID: userinfo, handler: { (proObj, isSuccess, strMessage) in
                            
                        })
                        
                        
                        //---------Update Modal for schdules as of day
                        ModelManager.sharedInstance.scheduleManager.getSchdulesByDay(strDay: NSDate().dayOfWeek()!) { (arrSchduleObj, isSuccess, responseMessage) in
                        }
                        
                        
                    }else{
                        
                        handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(nil , false ,(jsonDict.value(forKey: "message") as? String)!)
                }                
        })
    }
}
