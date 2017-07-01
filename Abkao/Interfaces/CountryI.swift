//
//  CountryI.swift
//  Abkao
//
//  Created by Apple on 28/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class CountryI: NSObject
{
    public var countryCode : String?
    public var countryName: String?
    public var geonameId : Int64?
    
    
    override init()
    {
        self.countryCode = ""
        self.countryName = ""
        self.geonameId = 0
    }

    public func setCountryInfo(dictData : [String : AnyObject])
    {
                
        self.geonameId = dictData["geonameId"] as? Int64
        self.countryCode = dictData["countryCode"] as? String ?? ""
        self.countryName =   dictData["countryName"] as? String ?? ""
        
        
    }
}
