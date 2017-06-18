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
    }
    
    public func setUserInfo(userObj : [String : AnyObject])
    {
        //        self.email =  (userObj["country_code"] as? String ?? "")
        //        self.firstName =  (userObj["country_code"] as? String ?? "")
        //        self.lastName = (userObj["country_code"] as? String ?? "")
        //        self.password = (userObj["country_code"] as? String ?? "")
        //        self.accountName = (userObj["country_code"] as? String ?? "")
        //        self.accountNo = (userObj["country_code"] as? String ?? "")
        //        self.address = (userObj["country_code"] as? String ?? "")
        //        self.city = (userObj["country_code"] as? String ?? "")
        //        self.state = (userObj["country_code"] as? String ?? "")
        //        self.zip = (userObj["country_code"] as? String ?? "")
        //        self.country = (userObj["country_code"] as? String ?? "")
        //        self.telephone = (userObj["country_code"] as? String ?? "")
        //        self.username = (userObj["country_code"] as? String ?? "")
        
        self.userID = userObj["userid"] as? Int
        print("user id : \(String(describing: self.userID!))")
        
    }
    
}
