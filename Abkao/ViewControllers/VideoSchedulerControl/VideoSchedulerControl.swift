//
//  VideoSchedulerControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class VideoSchedulerControl: AbstractControl,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var VideoSchedulerTable: UITableView!
    var arrProductImages = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        VideoSchedulerTable.delegate = self
        VideoSchedulerTable.dataSource = self
        VideoSchedulerTable.register(UINib(nibName: "VideoScheduler", bundle: nil), forCellReuseIdentifier: "VideoScheduler")
        VideoSchedulerTable.register(UINib(nibName: "VideoSchedulerHeader", bundle: nil), forCellReuseIdentifier: "VideoSchedulerHeader")
        VideoSchedulerTable.estimatedRowHeight = 100
        VideoSchedulerTable.rowHeight = UITableViewAutomaticDimension
        VideoSchedulerTable.separatorStyle = .none
        VideoSchedulerTable.tableFooterView = UIView()
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAllScheduledVideos()
    }
    
    override var navTitle: String{
        return "Logout"
    }
    
    override func gotoLoginView() {
        
    }
    
    func getAllScheduledVideos(){
        
        SVProgressHUD.show(withStatus: "Loding.....")
        ModelManager.sharedInstance.scheduleManager.getAllSchedules() { (productObj, isSuccess, responseMessage) in
            SVProgressHUD.dismiss()
            if(isSuccess){
                self.arrProductImages.removeAllObjects()
                self.arrProductImages.addObjects(from: productObj!)
                self.VideoSchedulerTable.reloadData()
            }else{
                SVProgressHUD.showError(withStatus: responseMessage)
            }
            
            
        }
        
    }

    func callProductDeleteAPI(productID: Int){
        
        let obj = SchedulerI()
        obj.scheduleID = productID
        SVProgressHUD.show(withStatus: "Loding.....")
        ModelManager.sharedInstance.scheduleManager.deleteSchedule(scheduleObj: obj) { (isSuccess, responseMessage) in
            SVProgressHUD.dismiss()
            if(isSuccess){
                 self.getAllScheduledVideos()
            }else{
                SVProgressHUD.showError(withStatus: responseMessage)
            }
           
        }
        
    }
    
    func setSelectedItems(image: UIImageView){
        image.image = #imageLiteral(resourceName: "tick")
    }
    
    
    //MARK: - UITableView Methods
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        // This is where you would change section header content
//        return tableView.dequeueReusableCell(withIdentifier: "VideoSchedulerHeader")
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//    {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoScheduler", for: indexPath) as! VideoScheduler
        
        let sehedulerObj = arrProductImages[indexPath.row] as! SchedulerI
        cell.lbl_StartTime.text = "Video Start time " + sehedulerObj.startTime!
        cell.lbl_EndTime.text = "Video End time " + sehedulerObj.endTime!
        cell.lbl_VideoURL.text = sehedulerObj.productVedUrl!
        
        for var day in sehedulerObj.arrDays! {
            
            if day == "Mon"{
                setSelectedItems(image: cell.img_Mon)
            }else if (day == "Tues"){
                setSelectedItems(image: cell.img_Tues)
            }else if (day == "Wed"){
                setSelectedItems(image: cell.img_Wed)
            }else if (day == "Thur"){
                setSelectedItems(image: cell.img_Thur)
            }else if (day == "Fri"){
                setSelectedItems(image: cell.img_Fri)
            }else if (day == "Sat"){
                setSelectedItems(image: cell.img_Sat)
            }else{
                setSelectedItems(image: cell.img_Sun)
            }
            
        }

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let sehedulerObj = arrProductImages[indexPath.row] as! SchedulerI
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "SetVideoSchedulerControl") as! SetVideoSchedulerControl
            myVC.getPreviousProducts = sehedulerObj
            myVC.status = "edit"
            self.navigationController?.pushViewController(myVC, animated: true)
            
        }
        editAction.backgroundColor = Constants.appColor.appEditColor
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            
            self.callProductDeleteAPI(productID: sehedulerObj.scheduleID!)
            
        }
        deleteAction.backgroundColor = Constants.appColor.appDeleteColor
        
        return [editAction,deleteAction]
    }
    


    @IBAction func btn_SetSchedulerAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goto_schedulerview", sender: nil)
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
