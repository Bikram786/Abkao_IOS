//
//  AuthManager.swift
//  Relay
//
//  Created by Sourcefuse on 17/01/17.
//  Copyright © 2017 iOS. All rights reserved.
//

import UIKit
import CoreData

class AuthManager: NSObject {
    
    
    var arrCountry : NSMutableArray?
    var arrStates : NSMutableArray?
    
    override init()
    {
        arrCountry = NSMutableArray()
        arrStates = NSMutableArray()
    }
    
    
    func userSignUp(userInfo: [String : Any], handler : @escaping (UserI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "register", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200){
                    
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess){
                        
                        //set User Object
                        self.setUserDefaultValues(dictData: jsonDict as! [String : AnyObject])
                        
                        ModelManager.sharedInstance.profileManager.userObj?.setUserInfo(userObj: jsonDict as! [String : AnyObject])
                        
                     
                        
                        handler(ModelManager.sharedInstance.profileManager.userObj! , true ,"User registered successfully")
                        
                    }else{
                        
                        handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
                
                
        })
    }
    
    func userLogin(userInfo: [String : Any], handler : @escaping (UserI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "login", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
                        ModelManager.sharedInstance.profileManager.userObj?.setUserInfo(userObj: jsonDict as! [String : AnyObject])
                        
                        //set User Object
                        self.setUserDefaultValues(dictData: jsonDict as! [String : AnyObject])
                        
                        
                        handler(ModelManager.sharedInstance.profileManager.userObj! , true ,(jsonDict.value(forKey: "message") as? String)!)
                    }
                    else
                    {
                         handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }
                else
                {
                    handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
              
                
        })
    }
    
    func logout(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .delete, strURL: "logout", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        
                        ModelManager.sharedInstance.profileManager.userObj?.resetData()
                        ModelManager.sharedInstance.settingsManager.settingObj?.resetData()
                        
                        //------save Settings Obj in defaults
                        let encodedSettings = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.settingsManager.settingObj!)
                        let userDefaults: UserDefaults = UserDefaults.standard
                        userDefaults.set(encodedSettings, forKey: "currentsetting")
                        
                        //------save User Obj in defaults
                        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.profileManager.userObj!)
                        userDefaults.set(encodedUser, forKey: "userinfo")
                        
                        userDefaults.synchronize()
                        
                        //-------
                        
                        handler(true,"User logout successfully")
                        
                    }else{
                        
                        handler(false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
                
                
        })
    }
    
    func forgotPassword(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "forgetpassword", headers: true, params: userInfo, result:
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
    
    func setUserDefaultValues(dictData : [String : AnyObject])
    {
        print("dictdata after successful login : \(dictData)")
        
        ModelManager.sharedInstance.settingsManager.settingObj?.imageGridRow = Int((dictData["image_grid_row"] as? String)!)
        ModelManager.sharedInstance.settingsManager.settingObj?.priceGridDimention = Int((dictData["price_grid_dimension"] as? String)!)
        ModelManager.sharedInstance.settingsManager.settingObj?.videoURL = (dictData["video_url"] as? String ?? "")
        ModelManager.sharedInstance.settingsManager.settingObj?.backGroundColor = (dictData["backgroundColor"] as? String ?? "")
        
        //save Settings Obj in defaults
        let encodedSettings = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.settingsManager.settingObj!)
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(encodedSettings, forKey: "currentsetting")
        
        //save User Obj in defaults
        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.profileManager.userObj!)
        userDefaults.set(encodedUser, forKey: "userinfo")
        
        userDefaults.synchronize()


    }
    
    
    func getCountriesList(handler : @escaping (NSMutableArray?, Bool) -> Void)
    {
        BaseWebAccessLayer.getRequestURLforContriesResponse(requestType: .get, strURL: "countryInfoJSON?username=chitram", headers: true, result:
            {                
                (jsonDict,statusCode) in
                
                if(statusCode == 200)
                {
                    let arrOfDict : NSArray = jsonDict.value(forKey: "geonames") as!  NSArray
                    self.arrCountry?.removeAllObjects()

                    for objAtindexI in arrOfDict
                    {
                        let countryObj = CountryI()
                        countryObj.setCountryInfo(dictData: objAtindexI as! [String : AnyObject])
                        self.arrCountry?.add(countryObj)
                        
                    }
                    handler(self.arrCountry!, true)
                    
                }
                else
                {
                    handler(nil, false)
                }
        })
    }
    
    func getStatesList(countryObj : CountryI, handler : @escaping (NSMutableArray?, Bool)-> Void)
    {
        
        let strUrl = "children?geonameId=\((countryObj.geonameId?.description)!)&username=singlabhi"
        
        //http://api.geonames.org/children?geonameId=1269750&username=singlabhi
        
        BaseWebAccessLayer.getRequestURLforContriesResponse(requestType: .get, strURL: strUrl, headers: true, result:
            {
                (jsonDict,statusCode) in
                                
                if(statusCode == 200)
                {
                    let arrOfDict : NSArray = jsonDict.value(forKey: "geonames") as!  NSArray
                    
                    self.arrStates?.removeAllObjects()
                    
                    for objAtindexI in arrOfDict
                    {
                        let stateObj = StateI()
                        stateObj.setStateInfo(dictData: objAtindexI as! [String : AnyObject])
                        self.arrStates?.add(stateObj)
                    }
                    
                    handler(self.arrStates!, true)
                    
                }
                else
                {
                    handler(nil, false)
                }
        })

    }
}
