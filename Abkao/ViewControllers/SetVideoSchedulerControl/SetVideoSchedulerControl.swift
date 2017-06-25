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

    var getPreviousProducts = SchedulerI()
    var status:String?
    var isCheckStartTime:Bool?
    var isCheckLastTime:Bool?
    var arrDays = NSMutableArray()
    var arrAllDays = ["Mon","Thes","Wed","Thus","Fri","Sat","Sun"]
    
    @IBOutlet weak var setTime: UIDatePicker!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var btn_StartTime: UIButton!
    @IBOutlet weak var btn_EndTime: UIButton!
    @IBOutlet weak var txt_VideoURL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateTimeView.isHidden=true
        txt_VideoURL.addShadowToTextfield()
        //var view = new UIView(new CGRect(View.Frame.Left, View.Frame.Height - 200, View.Frame.Right, 0));
        //view.BackgroundColor = UIColor.Clear;
    }

    @IBAction func btn_SetVideoTimeAction(_ sender: UIButton) {
        
        switch (sender.tag) {
        case (0):
            setButtonSelectedOrNot(button: sender)
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
        default:
            print("Buzz")
        }
    }
    
    
    func setButtonSelectedOrNot(button: UIButton){
        
        if button.isSelected {
            button.setImage(#imageLiteral(resourceName: "untick"), for: .normal)
            button.isSelected=false
            arrDays.remove(arrAllDays[button.tag])
        }else{
            button.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
            button.isSelected=true
            arrDays.add(arrAllDays[button.tag])
           
        }
        
    }
    
    func showAmination(){
       
    }
    
    
    @IBAction func btn_StartEndTimeAction(_ sender: UIButton) {
        
        dateTimeView.isHidden=false
        
        if sender.tag == 1 {
            isCheckStartTime = true
            isCheckLastTime = false
            
        }else{
            isCheckLastTime = true
            isCheckStartTime = false
        }
        
    }
    
    @IBAction func setTimeAction(_ sender: UIDatePicker) {
        
        print(sender.date)
       
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let dateString = formatter.string(from: sender.date)
        
        if isCheckStartTime == true {
            
            btn_StartTime.setTitle(dateString ,for: .normal)
        }
        
        if isCheckLastTime == true {
            
            btn_EndTime.setTitle(dateString ,for: .normal)
        }

        
        print(dateString)   // "4:44 PM on June 23, 2016\n"
        
        dateTimeView.isHidden=true
    }
    
    @IBAction func btn_SaveSchedulerVideoAction(_ sender: UIButton) {
        
        let obj = SchedulerI()
        obj.startTime = btn_StartTime.titleLabel?.text!
        obj.endTime = btn_EndTime.titleLabel?.text!
        obj.productVedUrl = "https://www.youtube.com/watch?v=5ahMQwxN9Js"
        obj.arrDays = arrDays as? [String]
        
        if status == "edit"{
            
            //dictData["product_id"] = getPreviousProducts.productID!
            
            
            SVProgressHUD.show(withStatus: "Loding.....")
            
            ModelManager.sharedInstance.scheduleManager.updateSchedule(scheduleObj: obj) { (userObj, isSuccess, strMessage) in
                
                if(isSuccess)
                {
                    SVProgressHUD.dismiss()
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
            }
            
        }else{
            
            ModelManager.sharedInstance.scheduleManager.addSchedule(scheduleObj: obj) { (userObj, isSuccess, strMessage) in
                
                if(isSuccess)
                {
                    SVProgressHUD.dismiss()
                    _ = self.navigationController?.popViewController(animated: true)
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
