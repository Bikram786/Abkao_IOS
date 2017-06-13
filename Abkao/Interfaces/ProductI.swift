//
//  ProductI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class ProductI: NSObject {

    //setter and getters
    public var productVedUrl: String?
    public var arrProductDesc : [ProductDescI]?
    public var arrProductPrice : [ProductPriceI]?


    
    
    override init()
    {
        self.productVedUrl = ""
        self.arrProductDesc = [ProductDescI]()
        self.arrProductPrice = [ProductPriceI]()

    }
    
    func resetData()
    {
        self.productVedUrl = ""
        self.arrProductDesc?.removeAll()
        self.arrProductPrice?.removeAll()

    }
    
    public func setProductDescData(productObj : [String : AnyObject])
    {
        self.productVedUrl =  (productObj["canceled_by"] as? String ?? "")
  
        
//        if let tempObj = productObj["trip_rides"] as? NSArray
//        {
//            for leg in tempObj
//            {
//                let tripLeg  = leg  as! [String : AnyObject]
//                
//                let tripRideCustomObj = TripRideI()
//                
//                tripRideCustomObj.setTripRideData(tripRideObj: tripLeg)
//                
//                self.arrProductDesc?.append(tripRideCustomObj)
//                
//            }
            
//        }
        
        
//        if let tripRidesSrvrObj = tripObj["trip_rides"] as? NSArray
//        {
//            for leg in tripRidesSrvrObj
//            {
//                let tripLeg  = leg  as! [String : AnyObject]
//                
//                let tripRideCustomObj = TripRideI()
//                
//                tripRideCustomObj.setTripRideData(tripRideObj: tripLeg)
//                
//                self.arrayProductPrice?.append(tripRideCustomObj)
//                
//            }
            
//        }

        
        
    }
    
}
