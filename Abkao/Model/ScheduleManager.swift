//
//  ScheduleManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ScheduleManager: NSObject {
    
    var dayName : String?
    
    let arrAllSchedules : NSMutableArray?
    let arrDaySchedules : NSMutableArray?
    
    override init()
    {
        arrAllSchedules  = NSMutableArray()
        arrDaySchedules = NSMutableArray()
    }
    
    
    func getAllSchedules(handler : @escaping ([SchedulerI]?, Bool , String) -> Void)
    {
        var dictData: [String : Any] = [:]
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getScheduleVideoByUserId", headers: true, params: dictData, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        let arrSchedule = jsonDict["video_list"] as? NSArray
                        self.arrAllSchedules?.removeAllObjects()
                        
                        for i in arrSchedule!
                        {
                            let dictObj  = i as! [String : AnyObject]
                            let scheduleObj = SchedulerI()
                            scheduleObj.setSchedules(scheduleObj: dictObj)
                            self.arrAllSchedules?.add(scheduleObj)
                        }
                        
                        handler(self.arrAllSchedules as? [SchedulerI], true,(jsonDict["message"] as? String)!)
                        
                    }else{
                       handler(nil, false,(jsonDict["message"] as? String)!)
                    }
                }else{
                   handler(nil, false,(jsonDict["message"] as? String)!)
                }
             
                
        })


    }
    
    func getSchdulesByDay(strDay: String, handler : @escaping ([SchedulerI]?, Bool , String) -> Void)
    {
        
        var dictData: [String : Any] = [:]
        //temp block

        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        dictData["day"] = strDay
        
        
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "getScheduleVideoByDay", headers: true, params: dictData, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        let arrSchedule = jsonDict["video_list"] as? NSArray
                        self.arrDaySchedules?.removeAllObjects()
                        for i in arrSchedule!
                        {
                            let dictObj  = i as! [String : AnyObject]
                            let scheduleObj = SchedulerI()
                            scheduleObj.setSchedules(scheduleObj: dictObj )
                            self.arrDaySchedules?.add(scheduleObj)
                        }
                        handler(self.arrDaySchedules as? [SchedulerI],true,(jsonDict["message"] as? String)!)
                        
                    }else{
                        
                        handler(nil, true,(jsonDict["message"] as? String)!)
                    }
                }else{
                    
                   handler(nil, true,(jsonDict["message"] as? String)!)
                }
              
        })

        
    }
    

    func deleteSchedule(scheduleObj : SchedulerI, handler : @escaping (Bool , String) -> Void)

    {
        var dictData: [String : Any] = [:]
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        dictData["scheduler_id"] = scheduleObj.scheduleID

        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "deleteScheduleVideo", headers: true, params: dictData, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        
                       handler(true,(jsonDict["message"] as? String)!)
                        
                    }else{
                        
                        handler(false,(jsonDict["message"] as? String)!)
                    }
                }else{
                    
                    handler(false,(jsonDict["message"] as? String)!)
                }
                
        })
    
    }
    
    func addSchedule(scheduleObj : SchedulerI, handler : @escaping (SchedulerI?, Bool , String) -> Void)
    {
        var dictData: [String : Any] = [:]
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        dictData["start_time"] = scheduleObj.startTime
        dictData["end_time"] = scheduleObj.endTime
        dictData["days"] = scheduleObj.arrDays
        dictData["video_link"] = scheduleObj.productVedUrl
        
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "scheduleVideo", headers: true, params: dictData, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        scheduleObj.setSchedules(scheduleObj: jsonDict as! [String : AnyObject])
                        handler(scheduleObj, true, (jsonDict["message"] as? String)!)
                        
                    }else{
                        handler(nil, false, (jsonDict["message"] as? String)!)
                    }
                }else{
                    handler(nil, false, (jsonDict["message"] as? String)!)
                }
               
        })
    }
    
    func updateSchedule(scheduleObj : SchedulerI, handler : @escaping (SchedulerI?, Bool , String) -> Void)
    {
        var dictData: [String : Any] = [:]
        dictData["scheduler_id"] = scheduleObj.scheduleID
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        dictData["start_time"] = scheduleObj.startTime
        dictData["end_time"] = scheduleObj.endTime
        dictData["days"] = scheduleObj.arrDays
        dictData["video_link"] = scheduleObj.productVedUrl
        
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "updateScheduleVideo", headers: true, params: dictData, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200){
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    if(isSuccess){
                        scheduleObj.setSchedules(scheduleObj: jsonDict as! [String : AnyObject])
                        handler(scheduleObj,true,(jsonDict["message"] as? String)!)
                        
                    }else{
                        handler(nil, false, (jsonDict["message"] as? String)!)
                    }
                }else{
                    handler(nil, false, (jsonDict["message"] as? String)!)
                }
          
        })
    }
}
