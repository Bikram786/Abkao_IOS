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
    
    
    
    func userSignUp(userInfo: [String : Any], handler : @escaping (UserI, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "register", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                ModelManager.sharedInstance.profileManager.userObj?.setUserInfo(userObj: jsonDict as! [String : AnyObject])
                
                //set User Object
                self.setUserDefaultValues()

                
                
                handler(ModelManager.sharedInstance.profileManager.userObj! , true ,(jsonDict.value(forKey: "message") as? String)!)
                
        })
    }
    
    func userLogin(userInfo: [String : Any], handler : @escaping (UserI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "login", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
                        ModelManager.sharedInstance.profileManager.userObj?.setUserInfo(userObj: jsonDict as! [String : AnyObject])
                        
                        //set User Object
                        self.setUserDefaultValues()
                        
                        
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
                
                
                
                print("user id : \(String(describing: (ModelManager.sharedInstance.profileManager.userObj?.userID)!))")
                //print(jsonDict)
                
                //handler(userObj, true,"User login successfully")
                
        })
    }
    
    func logout(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .delete, strURL: "logout", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                ModelManager.sharedInstance.profileManager.userObj?.resetData()
                
                handler(true,"User logout successfully")
                
        })
    }
    
    func forgotPassword(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "forgot", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                print(jsonDict)
                
                handler(true,"User logout successfully")
                
        })
    }
    
    func setUserDefaultValues()
    {
        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: ModelManager.sharedInstance.profileManager.userObj!)
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(encodedUser, forKey: "userinfo")
        userDefaults.synchronize()


    }
}
