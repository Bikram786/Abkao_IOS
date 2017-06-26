//
//  Settingsl.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Settingsl: NSObject {

    //setter and getters
    public var imageGridRow: String?
    public var priceGridDimention: String?
    public var videoURL: String?
  
    
    override init(){
        self.imageGridRow = ""
        self.priceGridDimention = ""
        self.videoURL = ""
    }
    
    
    func resetData(){
        self.imageGridRow = ""
        self.priceGridDimention = ""
        self.videoURL = ""
        }
    
    
    required init(coder decoder: NSCoder) {
        self.imageGridRow = decoder.decodeObject(forKey: "image_grid_row") as? String ?? ""
        self.priceGridDimention = decoder.decodeObject(forKey: "price_grid_dimension") as? String ?? ""
        self.videoURL = decoder.decodeObject(forKey: "video_url") as? String ?? ""
       
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(imageGridRow, forKey: "image_grid_row")
        coder.encode(priceGridDimention, forKey: "price_grid_dimension")
        coder.encode(videoURL, forKey: "video_url")
        
    }
    
    public func setSettingInfo(userObj : [String : AnyObject])
    {
        
        print("Login response : \(userObj)")
        
        let dictData : [String : AnyObject]  = userObj 
        self.imageGridRow = dictData["image_grid_row"] as? String ?? ""
        self.priceGridDimention = dictData["price_grid_dimension"] as? String ?? ""
        self.videoURL =   dictData["video_url"] as? String ?? ""
        
        
        
    }
    
    
}
