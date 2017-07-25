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
    
    
   // http://nexportretail.azurewebsites.net/api/PriceBookQuery/GetProductNamesNonCache/?upc=000002820000384
    
    
    func getAllProductsNames(productScannedId : String, handler : @escaping ([SpecialProductI]?, Bool , String) -> Void)
    {
        
        BaseWebAccessLayer.newAzureRequestURLWithArrayResponse(requestType: .get, strURL: "PriceBookQuery/GetProductNamesNonCache/?upc=\(productScannedId)", headers: true, params: nil, result:
            {
                (arrData,statusCode) in
                // success code
                
                print(arrData)
                
                if(arrData.count > 0)
                {
                    
                    self.arrAllSpecialProducts?.removeAll()
                    
                    
                    for dictObj in arrData
                    {
                        let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                        //print(tempProductInfoObj)
                        let specialProduct = SpecialProductI()
                        specialProduct.setProductName(dictData: tempProductInfoObj)
                        self.arrAllSpecialProducts?.append(specialProduct)
                    }
                    handler(self.arrAllSpecialProducts,true,"Product names Received")
                    
                    
                }else{
                    
                    handler(nil,false,"No names received")
                }
        })
    }
    
    
    func getSellingPrice(productScannedId : String, locationID : String, handler : @escaping (SellingPriceI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.newAzureRequestURLWithDictResponse(requestType: .get, strURL: "PriceBookQuery/GetProduct/?parameters=\(locationID),\(productScannedId)", headers: true, params: nil, result:
            {
                (dictInfoData,statusCode) in
                // success code
                
                print(dictInfoData)
                
                if ((dictInfoData.value(forKey: "LastPurchaseVendorName")) != nil)
                {
                    
                    
                    let sellingPriceI = SellingPriceI()
                    sellingPriceI.setSellingPrice(dictData: dictInfoData as! [String : AnyObject])
                    
                    handler(sellingPriceI,true,"Product names Received")
                    
                    
                }else{
                    
                    handler(nil,false,dictInfoData.value(forKey: "Message") as! String)
                }
        })
    }
    
    
    func getDepartments(locationId: String, handler : @escaping ([DepartmentI]?, Bool , String) -> Void) {
        
        BaseWebAccessLayer.newAzureRequestURLWithArrayResponse(requestType: .get, strURL: "ReferenceData/GetDepartments/?locationId=\(locationId)", headers: true, params: nil, result:
            {
                (arrData,statusCode) in
                // success code
                
                print(arrData)
                
                if(arrData.count > 0)
                {
                    
                    self.arrDepartments?.removeAll()
                    
                    
                    for dictObj in arrData
                    {
                        let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                        //print(tempProductInfoObj)
                        let departmentI = DepartmentI()
                        departmentI.setDepartmentInfo(dictData: tempProductInfoObj)
                        self.arrDepartments?.append(departmentI)
                    }
                    handler(self.arrDepartments,true,"Departments Received")
                    
                    
                }else{
                    
                    //handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                }
        })
        
        
    }
    
    func getAllPromotions(handler : @escaping ([PromotionI]?, Bool , String) -> Void) {
        
        BaseWebAccessLayer.newAzureRequestURLWithArrayResponse(requestType: .get, strURL: "Promotion/GetAllPromotions", headers: true, params: nil, result:
            {
                
                    (arrData,statusCode) in
                    // success code
                    
                    print(arrData)
                    
                    if(arrData.count > 0)
                    {
                        
                        self.arrAllPromotions?.removeAll()
                        
                        
                        for dictObj in arrData
                        {
                            let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                            //print(tempProductInfoObj)
                            let promotionI = PromotionI()
                            promotionI.setPromotionInfo(dictData: tempProductInfoObj)
                            
                            self.arrAllPromotions?.append(promotionI)
                        }
                        handler(self.arrAllPromotions,true,"Promotions Received")
                        
                        
                    }else{
                        
                        //handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                })
                
    }
    
    func getAllDiscounts(handler : @escaping ([DiscountI]?, Bool , String) -> Void) {
        
        BaseWebAccessLayer.newAzureRequestURLWithArrayResponse(requestType: .get, strURL: "ReferenceData/GetAllDiscounts", headers: true, params: nil, result:
            {
                
                (arrData,statusCode) in
                // success code
                
                print(arrData)
                
                if(arrData.count > 0)
                {
                    
                    self.arrAllDiscounts?.removeAll()
                    
                    
                    for dictObj in arrData
                    {
                        let tempProductInfoObj : [String : AnyObject] = dictObj as! [String : AnyObject]
                        print(tempProductInfoObj)
                        let discountI = DiscountI()
                        discountI.setDiscountInfo(dictData: tempProductInfoObj)
                        self.arrAllDiscounts?.append(discountI)
                    }
                    handler(self.arrAllDiscounts,true,"All Discounts Received")
                    
                    
                }else{
                    
                    //handler(nil,false,(jsonDict.value(forKey: "message") as? String)!)
                }
        })

        
    }
    
    func saveNewProduct(dictProductInfo: [String : Any], handler : @escaping (Bool) -> Void)  {
        
        BaseWebAccessLayer.newAzureRequestURLWithBoolResponse(requestType: .post, strURL: "PriceBookQuery/PostProductFastSingle", headers: true, params: dictProductInfo, result:
            {
                (isSuccess) in
                
                handler(isSuccess)
        })

        
    }
    
}
