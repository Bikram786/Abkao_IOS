//
//  StateI.swift
//  Abkao
//
//  Created by Apple on 28/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class StateI: NSObject {

    public var stateName: String?
    public var geonameId : Int64?
    
    
    override init()
    {
        self.stateName = ""
        self.geonameId = 0
    }
    
    public func setStateInfo(dictData : [String : AnyObject])
    {        
        self.geonameId = dictData["geonameId"] as? Int64
        self.stateName =   dictData["name"] as? String ?? ""
    }
    
}
