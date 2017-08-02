//
//  SummaryVC.swift
//  Abkao
//
//  Created by Abhishek Singla on 22/07/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class SummaryVC: AbstractControl {

    @IBOutlet weak var setViewShadow: UIView!

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!

    @IBOutlet weak var constraintView4: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        let strQuestion4 = ModelManager.sharedInstance.questionManager.dictQuestion["question4"] as! String
        
        if(strQuestion4 == "0")
        {
            constraintView4.constant = 0
        }
        
        
        let dictData = ModelManager.sharedInstance.questionManager.dictQuestion
        
        print(dictData)
        
        
        let objDepartment = dictData["question3"] as! DepartmentI
        
        
        
        lbl1.text = "\(String(describing: dictData["question1"] as! String))"
        lbl2.text = "\(String(describing: dictData["question2"] as! String))$"
        lbl3.text = objDepartment.departmentName
        lbl4.text = "\(String(describing: dictData["question4"] as! String))"
        
        if (dictData["question5"] is String)
        {
            lbl5.text = "No Thanks"
        }
        else
        {
            let objPromotion = dictData["question5"] as! PromotionI
            lbl5.text = objPromotion.name

        }
        
        
        if (dictData["question6"] is String)
        {
            lbl6.text = "No Thanks"
        }
        else
        {
            let objDiscount = dictData["question6"] as! DiscountI
            lbl6.text = objDiscount.recordName
            
        }
        
    }
    
    override var navTitle: String {
        
        return "OnlyLeftBack"
    }
    
    
    func saveAllData(dictData : [String : AnyObject])  {
        
        var dictPostData : [String : AnyObject] = [:]
        
        
        let objDepartment = dictData["question3"] as! DepartmentI
        

        if (dictData["question5"] is String)
        {
            dictPostData["PromotionName"] = "No Thanks" as AnyObject
        }
        else
        {
            let objPromotion = dictData["question5"] as! PromotionI
            
            dictPostData["PromotionName"] = objPromotion.name as AnyObject
            
        }
        
        
        if (dictData["question6"] is String)
        {
            dictPostData["DiscountItemCode"] = "No Thanks" as AnyObject
        }
        else
        {
            let objDiscount = dictData["question6"] as! DiscountI
            dictPostData["DiscountItemCode"] = objDiscount.skuNo as AnyObject
            
        }
        
        
        
        
        
        dictPostData["Locationid"] = ModelManager.sharedInstance.profileManager.userObj!.accountNo as AnyObject
        dictPostData["ItemCode"] = ModelManager.sharedInstance.barcodeManager.barCodeValue as AnyObject
        
        dictPostData["Token"] = "NexgenceRetail$1" as AnyObject

        dictPostData["ItemName"] = dictData["question1"] as AnyObject
        dictPostData["Price"] = dictData["question2"]
        dictPostData["DepartmentId"] = objDepartment.departmentNo as AnyObject
        dictPostData["ContainerSize"] = dictData["question4"]
        
        
        print("Response : \(dictPostData)")
        
        //temp code
//        return
        
        ModelManager.sharedInstance.questionManager.saveNewProduct(dictProductInfo: dictPostData) { (isSuccess) in
            
            if(isSuccess)
            {
                print("new product from barcode : Successfuly added")
                
                ModelManager.sharedInstance.questionManager.resetDictInfo()
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                for aViewController in viewControllers {
                    if aViewController is HomeControl {
                        self.navigationController!.popToViewController(aViewController, animated: true)
                    }
                }
            }
            else
            {
                
                ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Error!", strDialogMessege: "New product details not saved because of technical error, please try again.")
                


            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clkSubmit(_ sender: UIButton) {
        
        saveAllData(dictData: ModelManager.sharedInstance.questionManager.dictQuestion)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
