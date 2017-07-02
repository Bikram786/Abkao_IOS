//
//  SetVideoSchedulerControl.swift
//  Abkao
//
//  Created by Inder on 25/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit
import SVProgressHUD

class SetVideoSchedulerControl: AbstractControl {

    var getPreviousProducts = SchedulerI()
    var status:String?
    var isCheckStartTime:Bool?
    var isCheckLastTime:Bool?
    var arrDays = NSMutableArray()
    var arrAllDays = ["Mon","Thes","Wed","Thus","Fri","Sat","Sun"]
    var checkStartDate:Date?
    var checkEndDate:Date?
    
    @IBOutlet weak var setTime: UIDatePicker!
    @IBOutlet weak var dateTimeView: UIView!
    @IBOutlet weak var btn_StartTime: UIButton!
    @IBOutlet weak var btn_EndTime: UIButton!
    @IBOutlet weak var txt_VideoURL: UITextField!
    
    // Set Days Outlets
    
    @IBOutlet weak var btn_Mon: UIButton!
    @IBOutlet weak var btn_Tues: UIButton!
    @IBOutlet weak var btn_Wed: UIButton!
    @IBOutlet weak var btn_Thur: UIButton!
    @IBOutlet weak var btn_Fri: UIButton!
    @IBOutlet weak var btn_Sat: UIButton!
    @IBOutlet weak var btn_Sun: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkStartDate = Date()
        checkEndDate = Date()
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        dateTimeView.isHidden=true
        txt_VideoURL.addShadowToTextfield()
        
        if status == "edit"{
            
            btn_StartTime.setTitle(getPreviousProducts.startTime!, for: .normal)
            btn_EndTime.setTitle(getPreviousProducts.endTime!, for: .normal)
            txt_VideoURL.text = getPreviousProducts.productVedUrl!
            arrDays.addObjects(from: getPreviousProducts.arrDays!)
            
            let stDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: getPreviousProducts.startTime!)
            let endDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: getPreviousProducts.endTime!)

            checkStartDate = stDate
            checkEndDate = endDate
            
            print("Start date : \(stDate), End date : \(endDate)")
//            if(stDate.compare(endDate) == .orderedDescending)
//            {
//                print("ordereDescending")
//            }
//            else
//            {
//                print("ordereAescending")
//
//            }
            
            
            for var day in getPreviousProducts.arrDays! {
                
               if day == "Mon"{
                setSelectedItems(button: btn_Mon)
               }else if (day == "Tues"){
                setSelectedItems(button: btn_Tues)
               }else if (day == "Wed"){
                setSelectedItems(button: btn_Wed)
               }else if (day == "Thur"){
                setSelectedItems(button: btn_Thur)
               }else if (day == "Fri"){
                setSelectedItems(button: btn_Fri)
               }else if (day == "Sat"){
                setSelectedItems(button: btn_Sat)
               }else{
                setSelectedItems(button: btn_Sun)
               }

            }
        }else{
            
            txt_VideoURL.text = ModelManager.sharedInstance.settingsManager.settingObj?.videoURL
        }
        
    }
    
    override var showRight: Bool{
        return false
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
    
    
    func setSelectedItems(button: UIButton){
        
        button.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
        button.isSelected=true
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let dateString = formatter.string(from: sender.date)
        
        if isCheckStartTime == true {
            
            checkStartDate = sender.date
            btn_StartTime.setTitle(dateString ,for: .normal)
        }
        
        if isCheckLastTime == true {
            
            checkEndDate = sender.date
            btn_EndTime.setTitle(dateString ,for: .normal)
        }
                
        dateTimeView.isHidden=true
    }
    
    @IBAction func btn_SaveSchedulerVideoAction(_ sender: UIButton) {
        
        
        if checkStartDate! > checkEndDate! {
            SVProgressHUD.showError(withStatus: "Starting time not more than end time")
        }else{
            
            let obj = SchedulerI()
            obj.startTime = btn_StartTime.titleLabel?.text!
            obj.endTime = btn_EndTime.titleLabel?.text!
            obj.productVedUrl = txt_VideoURL.text!
            obj.arrDays = arrDays as? [String]
            
            if status == "edit"{
                
                obj.scheduleID = getPreviousProducts.scheduleID
                
                SVProgressHUD.show(withStatus: "Loading.....")
                
                ModelManager.sharedInstance.scheduleManager.updateSchedule(scheduleObj: obj) { (userObj, isSuccess, strMessage) in
                    SVProgressHUD.dismiss()
                    if(isSuccess){
                        _ = self.navigationController?.popViewController(animated: true)
                    }else{
                        SVProgressHUD.showError(withStatus: strMessage)
                    }
                    
                }
                
            }else{
                
                ModelManager.sharedInstance.scheduleManager.addSchedule(scheduleObj: obj) { (userObj, isSuccess, strMessage) in
                    
                    if(isSuccess){
                        _ = self.navigationController?.popViewController(animated: true)
                    }else{
                        SVProgressHUD.showError(withStatus: strMessage)
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
