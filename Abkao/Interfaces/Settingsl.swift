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
        
}
