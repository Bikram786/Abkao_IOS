//
//  DepartmentI.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class DepartmentI: NSObject {

    public var departmentName: String?
//    public var departmentId: Int64?
    public var departmentNo : Int64?
    public var masterDepartmentNo : Int64?
    
    override init()
    {
        self.departmentName = ""
//        self.departmentId = 0
        self.departmentNo = 0
        self.masterDepartmentNo = 0
    }
    
    public func setDepartmentInfo(dictData : [String : AnyObject])
    {
        self.departmentName =   dictData["Name"] as? String ?? ""
//        self.departmentId = dictData["MasterDepartmentId"] as? Int64
        self.departmentNo =   dictData["Number"] as? Int64
        self.masterDepartmentNo = dictData["MasterDepartmentId"] as? Int64
    }

}
