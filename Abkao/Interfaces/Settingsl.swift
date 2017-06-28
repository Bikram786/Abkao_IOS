//
//  Settingsl.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class Settingsl: NSObject,NSCoding {

    //setter and getters
    public var imageGridRow: Int?
    public var priceGridDimention: Int?
    public var videoURL: String?
  
    
    override init(){
        self.imageGridRow = 0
        self.priceGridDimention = 0
        self.videoURL = ""
    }
    
    
    func resetData(){
        self.imageGridRow = 0
        self.priceGridDimention = 0
        self.videoURL = ""
        }
    
    required init(coder decoder: NSCoder)
    {
        self.videoURL = decoder.decodeObject(forKey: "videoURL") as? String ?? ""
        self.priceGridDimention = decoder.decodeObject(forKey: "priceGridDimention") as? Int ?? decoder.decodeInteger(forKey: "priceGridDimention")
        self.imageGridRow = decoder.decodeObject(forKey: "imageGridRow") as? Int ?? decoder.decodeInteger(forKey: "imageGridRow")
    }
    
    
    func encode(with coder: NSCoder)
    {
        coder.encode(videoURL, forKey: "videoURL")
        coder.encode(priceGridDimention, forKey: "priceGridDimention")
        coder.encode(imageGridRow, forKey: "imageGridRow")
    }
    
}
