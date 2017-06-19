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
    var productDescManager : ProductDescManager
    var productPriceManager : ProductPriceManager
    var barcodeManager : BarcodeManager
    var scheduleManager : ScheduleManager
    var imageCellManager : ImageCellManager
    var priceCellManager : PriceCellManager
    var profileManager : ProfileManager
    
    static let sharedInstance = ModelManager()
    
    fileprivate override init()
    {
        authManager = AuthManager()
        productManager = ProductManager()
        settingsManager = SettingsManager()
        productDescManager = ProductDescManager()
        productPriceManager = ProductPriceManager()
        barcodeManager = BarcodeManager()
        scheduleManager = ScheduleManager()
        imageCellManager = ImageCellManager()
        priceCellManager = PriceCellManager()
        profileManager = ProfileManager()
        
    }
    
}
