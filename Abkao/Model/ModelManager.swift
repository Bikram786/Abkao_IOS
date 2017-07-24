//
//  ModelManager.swift
//  Relay
//
//  Created by sourcefuse on 17/01/17.
//  Copyright © 2017 iOS. All rights reserved.
//

import UIKit

class ModelManager: NSObject {
    
    var authManager:AuthManager
    var productManager : ProductManager
    var settingsManager : SettingsManager
    var barcodeManager : BarcodeManager
    var scheduleManager : ScheduleManager
    var imageCellManager : ImageCellManager
    var priceCellManager : PriceCellManager
    var profileManager : ProfileManager
    var questionManager : QuestionManager
    
    static let sharedInstance = ModelManager()
    
    fileprivate override init()
    {
        authManager = AuthManager()
        productManager = ProductManager()
        settingsManager = SettingsManager()
        barcodeManager = BarcodeManager()
        scheduleManager = ScheduleManager()
        imageCellManager = ImageCellManager()
        priceCellManager = PriceCellManager()
        profileManager = ProfileManager()
        questionManager = QuestionManager()
        
    }
    
}
