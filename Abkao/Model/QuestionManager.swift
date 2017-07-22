//
//  QuestionManager.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class QuestionManager: NSObject {

    var dictQuestion : [String : AnyObject]
    
    var arrAllSpecialProducts : [SpecialProductI]?
    
    var arrDepartments: [DepartmentI]?

    var arrAllPromotions: [PromotionI]?

    var arrAllDiscounts : [DiscountI]?

    
    override init()
    {
        dictQuestion  = [:]
        
        arrAllSpecialProducts = [SpecialProductI]()
        arrDepartments = [DepartmentI]()
        arrAllPromotions = [PromotionI]()
        arrAllDiscounts = [DiscountI]()
    }
    
    func resetDictInfo()  {
        
        dictQuestion.removeAll()
        arrAllSpecialProducts?.removeAll()
    }
    
    func getAllSpecialProducts(handler : @escaping ([SpecialProductI]?, Bool , String) -> Void)
    {
        
        BaseWebAccessLayer.newAzureRequestURLWithDictionaryResponse(requestType: .get, strURL: "", headers: true, params: nil, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                if(jsonDict.value(forKey: "success") as! Bool)
                {
                    
                    if(statusCode == 200){
                        
                        let data = jsonDict.value(forKey: "data") as! NSDictionary
                        let isSuccess = data["success"] as! Bool
                        if(isSuccess){
                            
                            
                            var productInfoObj : [String : AnyObject] = jsonDict.value(forKey: "data") as! [String : AnyObject]
                            
                            self.arrAllSpecialProducts?.removeAll()
                            
                            let arrData = productInfoObj["image_grid"] as! NSArray
                            
                            if(arrData.count > 0)
                            {
                                for dictObj in arrData
                                {
                                    let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                                    
                                    let specialProductI = SpecialProductI()
                                    specialProductI.setSpecialProductInfo(dictData: tempProductInfoObj )
                                    self.arrAllSpecialProducts?.append(specialProductI)
                                }
                            }
                            
                            handler(self.arrAllSpecialProducts,true,"Products Received")
                            
                        }else{
                            
                            handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                        }
                    }
                    else{
                        
                        handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                    
                }
                
        })
    }
    
    
    
    func getDepartments(locationId: String, handler : @escaping ([DepartmentI]?, Bool , String) -> Void) {
        
        BaseWebAccessLayer.newAzureRequestURLWithDictionaryResponse(requestType: .get, strURL: "ReferenceData/GetDepartments/?locationId=\(locationId)", headers: true, params: nil, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                if(jsonDict.value(forKey: "success") as! Bool)
                {
                    
                    if(statusCode == 200){
                        
                        let data = jsonDict.value(forKey: "data") as! NSDictionary
                        let isSuccess = data["success"] as! Bool
                        if(isSuccess){
                            
                            
                            var productInfoObj : [String : AnyObject] = jsonDict.value(forKey: "data") as! [String : AnyObject]
                            
                            self.arrDepartments?.removeAll()
                            
                            let arrData = productInfoObj["image_grid"] as! NSArray
                            
                            if(arrData.count > 0)
                            {
                                for dictObj in arrData
                                {
                                    let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                                    
                                    let departmentI = DepartmentI()
                                    departmentI.setDepartmentInfo(dictData: tempProductInfoObj)
                                    self.arrDepartments?.append(departmentI)
                                }
                            }
                            
                            handler(self.arrDepartments,true,"Departments Received")
                            
                        }else{
                            
                            handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                        }
                    }
                    else{
                        
                        handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                    
                }
                
        })

        
    }
    
    func getAllPromotions(handler : @escaping ([PromotionI]?, Bool , String) -> Void) {
        
        BaseWebAccessLayer.newAzureRequestURLWithDictionaryResponse(requestType: .get, strURL: "Promotion/GetAllPromotions", headers: true, params: nil, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                if(jsonDict.value(forKey: "success") as! Bool)
                {
                    
                    if(statusCode == 200){
                        
                        let data = jsonDict.value(forKey: "data") as! NSDictionary
                        let isSuccess = data["success"] as! Bool
                        if(isSuccess){
                            
                            
                            var productInfoObj : [String : AnyObject] = jsonDict.value(forKey: "data") as! [String : AnyObject]
                            
                            self.arrAllSpecialProducts?.removeAll()
                            
                            let arrData = productInfoObj["image_grid"] as! NSArray
                            
                            if(arrData.count > 0)
                            {
                                for dictObj in arrData
                                {
                                    let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                                    
                                    let promotionI = PromotionI()
                                    promotionI.setPromotionInfo(dictData: tempProductInfoObj)
                                    
                                    self.arrAllPromotions?.append(promotionI)
                                }
                            }
                            
                            handler(self.arrAllPromotions,true,"Products Received")
                            
                        }else{
                            
                            handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                        }
                    }
                    else{
                        
                        handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                    
                }
                
        })

        
    }
    
    func getAllDiscounts(handler : @escaping ([DiscountI]?, Bool , String) -> Void) {
        
        BaseWebAccessLayer.newAzureRequestURLWithDictionaryResponse(requestType: .get, strURL: "ReferenceData/GetAllDiscounts", headers: true, params: nil, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                print(jsonDict)
                
                if(jsonDict.value(forKey: "success") as! Bool)
                {
                    
                    if(statusCode == 200){
                        
                        let data = jsonDict.value(forKey: "data") as! NSDictionary
                        let isSuccess = data["success"] as! Bool
                        if(isSuccess){
                            
                            
                            var productInfoObj : [String : AnyObject] = jsonDict.value(forKey: "data") as! [String : AnyObject]
                            
                            self.arrAllSpecialProducts?.removeAll()
                            
                            let arrData = productInfoObj["image_grid"] as! NSArray
                            
                            if(arrData.count > 0)
                            {
                                for dictObj in arrData
                                {
                                    let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                                    
                                    let discountI = DiscountI()
                                    discountI.setDiscountInfo(dictData: tempProductInfoObj)
                                    
                                    self.arrAllDiscounts?.append(discountI)
                                }
                            }
                            
                            handler(self.arrAllDiscounts,true,"Products Received")
                            
                        }else{
                            
                            handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                        }
                    }
                    else{
                        
                        handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                    
                }
        })

        
    }
    
    func saveNewProduct(dictProductInfo: [String : Any], handler : @escaping ( Bool , String) -> Void)  {
        
    }
    
}
