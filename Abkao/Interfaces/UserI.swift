//
//  UserI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class UserI: NSObject {
    
    //setter and getters
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var password: String?
    public var accountName: String?
    public var accountNo: String?
    public var address: String?
    public var city: String?
    public var state: String?
    public var zip: String?
    public var country: String?
    public var telephone: String?
    public var username: String?
    public var userID: Int?
    
    public var imageGridSize: Int?
    public var priceGridSize: Int?
    public var defaultUrl : String?
    
    
    override init(){
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.password = ""
        self.accountName = ""
        self.accountNo = ""
        self.address = ""
        self.city = ""
        self.state = ""
        self.zip = ""
        self.country = ""
        self.telephone = ""
        self.username = ""
        self.defaultUrl = ""
        self.imageGridSize = 0
        self.priceGridSize = 0
        self.userID = 0
    }
    
    func resetData(){
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.password = ""
        self.accountName = ""
        self.accountNo = ""
        self.address = ""
        self.city = ""
        self.state = ""
        self.zip = ""
        self.country = ""
        self.telephone = ""
        self.username = ""
        self.userID = 0
        self.defaultUrl = ""
        self.imageGridSize = 0
        self.priceGridSize = 0
    }
    
    public func setUserInfo(userObj : [String : AnyObject])
    {
        
        print("Login response : \(userObj)")
        
        let arrData : NSArray = userObj["userdetails"] as! NSArray
        let dictData : [String : AnyObject]  = arrData.object(at: 0) as! [String : AnyObject]
        
        /*
                self.email =  (userObj["email"] as? String ?? "")
                self.firstName =  (userObj["first_name"] as? String ?? "")
                self.lastName = (userObj["last_name"] as? String ?? "")
                self.password = (userObj["password"] as? String ?? "")
                self.accountName = (userObj["account_name"] as? String ?? "")
                self.accountNo = (userObj["account_number"] as? String ?? "")
                self.address = (userObj["address"] as? String ?? "")
                self.city = (userObj["city"] as? String ?? "")
                self.state = (userObj["state"] as? String ?? "")
                self.zip = (userObj["zip"] as? String ?? "")
                self.country = (userObj["country"] as? String ?? "")
                self.telephone = (userObj["telephone"] as? String ?? "")
                self.username = (userObj["username"] as? String ?? "")
        */
        
                self.userID = dictData["userid"] as? Int
                self.defaultUrl = (userObj["video_url"] as? String ?? "")
                self.imageGridSize = userObj["image_grid_row"] as? Int
                self.priceGridSize = userObj["price_grid_dimension"] as? Int
        
                UserDefaults.standard.set(userObj["userid"] as? Int, forKey: "userID")
                UserDefaults.standard.synchronize()
        
                print("user id : \(String(describing: self.userID!))")
        
    }
    
    public func getUserSavedID(){
    
        self.userID = UserDefaults.standard.value(forKey: "userID") as? Int
   }
}
