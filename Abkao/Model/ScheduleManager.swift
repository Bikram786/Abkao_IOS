//
//  ScheduleManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ScheduleManager: NSObject {
    
    let arrAllSchedules : NSMutableArray?
    
    override init()
    {
        arrAllSchedules  = NSMutableArray()
    }
    
    
    func getAllSchedules(userID: [String : Any], handler : @escaping ([SchedulerI], Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getScheduleVideoByUserId", headers: true, params: userID, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                let arrSchedule = jsonDict["video_list"] as? NSArray
                self.arrAllSchedules?.removeAllObjects()
                
                for i in arrSchedule!
                {
                    let dictObj  = i as! [String : AnyObject]
                    let scheduleObj = SchedulerI()
                    scheduleObj.setSchedules(scheduleObj: dictObj)
                    self.arrAllSchedules?.add(scheduleObj)
                }
                
                handler(self.arrAllSchedules as! [SchedulerI],true,(jsonDict["message"] as? String)!)
                
        })


    }
    
    func getSchdulesByDay(dictData: [String : Any], handler : @escaping ([SchedulerI], Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getScheduleVideoByDay", headers: true, params: dictData, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                let arrSchedule = jsonDict["video_list"] as? NSArray
                
                var arrScheduleObj = [SchedulerI]()
                for i in arrSchedule!
                {
                    let dictObj  = i as! [String : AnyObject]
                    let scheduleObj = SchedulerI()
                    scheduleObj.setSchedules(scheduleObj: dictObj )
                    arrScheduleObj.append(scheduleObj)
                }
                
                handler(arrScheduleObj,true,(jsonDict["message"] as? String)!)
                
        })

        
    }
    
    func deleteSchedule(userID: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
    
    }
    
    func addSchedule(userID: [String : Any], handler : @escaping (SchedulerI, Bool , String) -> Void)
    {
        
    }
    
    func updateSchedule(userID: [String : Any], handler : @escaping (SchedulerI, Bool , String) -> Void)
    {
        
    }
}
