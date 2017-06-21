//
//  SchedulerI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class SchedulerI: NSObject {

    public var productVedUrl: String?
    public var scheduleID : Int?
    public var arrDays : [String]?
    public var startTime: String?
    public var endTime: String?
    
    
    
    override init(){
        self.productVedUrl = ""
        self.scheduleID = 0
        self.arrDays = [String]()
        self.startTime = ""
        self.endTime = ""
    }
    
    
    func resetData()
    {
        self.productVedUrl = ""
        self.scheduleID = 0
        self.arrDays?.removeAll()
        self.startTime = ""
        self.endTime = ""
    }
    
    
    public func setSchedules(scheduleObj : [String : AnyObject])
    {
        self.productVedUrl =  (scheduleObj["video_link"] as? String ?? "")
        self.scheduleID = Int((scheduleObj["scheduler_id"] as? String)!)
        self.startTime = (scheduleObj["start_time"] as? String)!
        self.endTime = (scheduleObj["end_time"] as? String)!
        self.arrDays = scheduleObj["days"] as? NSArray as? [String]        
        
    }
    
}
