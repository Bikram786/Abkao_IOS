//
//  SetVideoSchedulerControl.swift
//  Abkao
//
//  Created by Inder on 25/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD

class SetVideoSchedulerControl: UIViewController {

    var status:String?
    
    @IBOutlet weak var setTime: UIDatePicker!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var btn_StartTime: UIButton!
    @IBOutlet weak var btn_EndTime: UIButton!
    @IBOutlet weak var txt_VideoURL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateTimeView.isHidden=true
        txt_VideoURL.addShadowToTextfield()
    }

    @IBAction func btn_SetVideoTimeAction(_ sender: UIButton) {
        
        switch (sender.tag) {
        case (1):
            setButtonSelectedOrNot(button: sender)
        case (2):
            setButtonSelectedOrNot(button: sender)
        case (3):
            setButtonSelectedOrNot(button: sender)
        case (4):
            setButtonSelectedOrNot(button: sender)
        case (5):
            setButtonSelectedOrNot(button: sender)
        case (6):
            setButtonSelectedOrNot(button: sender)
        case (7):
            setButtonSelectedOrNot(button: sender)
        default:
            print("Buzz")
        }
    }
    
    
    func setButtonSelectedOrNot(button: UIButton){
        
        if button.isSelected {
            
            button.setImage(#imageLiteral(resourceName: "untick"), for: .normal)
            button.isSelected=false
            
        }else{
            
            button.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
            button.isSelected=true
        }
        
    }
    
    @IBAction func btn_StartTimeAction(_ sender: UIButton) {
        
        dateTimeView.isHidden=false
    }
    
    @IBAction func btn_EndTimeAction(_ sender: UIButton) {
        
        dateTimeView.isHidden=false
    }
    
    
    @IBAction func setTimeAction(_ sender: UIDatePicker) {
        
        
       
    }
    
    @IBAction func btn_SaveSchedulerVideoAction(_ sender: UIButton) {
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["product_name"] = ""
        dictData["product_price"] = ""
        dictData["userid"] = "5"
//        
//        if status == "edit"{
//            
//            //dictData["product_id"] = getPreviousProducts.productID!
//            
//            
//            SVProgressHUD.show(withStatus: "Loding.....")
//            
//            ModelManager.sharedInstance.scheduleManager.updateSchedule(scheduleObj: dictData) { (userObj, isSuccess, strMessage) in
//                
//                if(isSuccess)
//                {
//                    SVProgressHUD.dismiss()
//                    _ = self.navigationController?.popViewController(animated: true)
//                }
//                
//            }
//            
//        }else{
//            
//            ModelManager.sharedInstance.scheduleManager.addSchedule(scheduleObj: dictData) { (userObj, isSuccess, strMessage) in
//                
//                if(isSuccess)
//                {
//                    SVProgressHUD.dismiss()
//                    _ = self.navigationController?.popViewController(animated: true)
//                }
//                
//            }
//        }

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
