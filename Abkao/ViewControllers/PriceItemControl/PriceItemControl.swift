//
//  PriceItemControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class PriceItemControl: AbstractControl {
    
    var getPreviousProducts = ProductPriceI()
    var status:String?
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_ProductName: UITextField!
    @IBOutlet weak var txt_ProductPrice: UITextField!
    @IBOutlet weak var btn_Save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
    }
    
    func setStartingFields() {
        
        // upperView.upperdraw(upperView.bounds)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_ProductName.addShadowToTextfield()
        txt_ProductPrice.addShadowToTextfield()
        
        if status == "edit"{
            
            txt_ProductName.text = getPreviousProducts.productName
            txt_ProductPrice.text = getPreviousProducts.productRate
            btn_Save.setTitle("Update", for: .normal)
            
        }else{
            
            btn_Save.setTitle("Save", for: .normal)
        }
        
    }
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    
    @IBAction func btn_SaveAction(_ sender: UIButton) {
        
        if (txt_ProductName.text?.isEmpty)! || (txt_ProductPrice.text?.isEmpty)! {
            
            
        }else{
            
            var  dictData : [String : Any] =  [String : Any]()
            dictData["product_name"] = txt_ProductName.text!
            dictData["product_price"] = txt_ProductPrice.text!
            dictData["userid"] = "5"
            if status == "edit"{
                
                dictData["product_id"] = getPreviousProducts.productID!
                
                ModelManager.sharedInstance.priceCellManager.updateRecord(userInfo: dictData) { (userObj, isSuccess, strMessage) in
                    
                    if(isSuccess)
                    {
                        
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    
                }
                
            }else{
                
                ModelManager.sharedInstance.priceCellManager.addNewRecord(userInfo: dictData) { (userObj, isSuccess, strMessage) in
                    
                    if(isSuccess)
                    {
                        
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
