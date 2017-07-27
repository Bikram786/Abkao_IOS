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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        let dictData = ModelManager.sharedInstance.questionManager.dictQuestion
        
        lbl1.text = "Ans. \(String(describing: dictData["question1"] as! String))"
        lbl2.text = "Ans. \(String(describing: dictData["question2"] as! String))$"
        lbl3.text = "Ans. \(String(describing: dictData["question3"] as! String))"
        lbl4.text = "Ans. \(String(describing: dictData["question4"] as! String))"
        lbl5.text = "Ans. \(String(describing: dictData["question5"] as! String))"
        lbl6.text = "Ans. \(String(describing: dictData["question6"] as! String))"
        

    }
    
    override var navTitle: String {
        
        return "OnlyLeftBack"
    }
    
    
    func saveAllData(dictData : [String : AnyObject])  {
        
        
        var dictPostData : [String : AnyObject] = [:]
        
        dictPostData["Locationid"] = ModelManager.sharedInstance.profileManager.userObj?.accountNo as AnyObject
        dictPostData["ItemCode"] = ModelManager.sharedInstance.barcodeManager.barCodeValue as AnyObject
        
        dictPostData["Token"] = "NexgenceRetail$1" as AnyObject

        dictPostData["ItemName"] = dictData["question1"]
        dictPostData["Price"] = dictData["question2"]
        dictPostData["DepartmentId"] = dictData["question3"]
        dictPostData["ContainerSize"] = dictData["question4"]
        dictPostData["PromotionName"] = dictData["question5"]
        dictPostData["DiscountItemCode"] = dictData["question6"]
        
        print("Response : \(dictPostData)")
        
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
                print("ooooooppps")

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
