//
//  HomeControl.swift
//  Abkao
//
//  Created by Inder on 10/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import YouTubePlayer
import AVKit
import AVFoundation
import AlamofireImage
import SVProgressHUD
import UserNotifications

class HomeControl: AbstractControl,UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var setClv: UICollectionView!
    @IBOutlet weak var leftTbl: UITableView!
    @IBOutlet weak var rightTbl: UITableView!
    @IBOutlet weak var youTubeView: YouTubePlayerView!
    @IBOutlet weak var simpleVideoView: UIView!
    
    var productObj : ProductI?
    var setImageGrid : Int?
    var setPriceGrid : Int?
    
    var arrProductDes = NSMutableArray()
    var arrProductPrice = NSMutableArray()
    var leftData = NSMutableArray()
    var rightData = NSMutableArray()
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.data(forKey: "userinfo"),
            
            let myUserObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserI {
            
            ModelManager.sharedInstance.profileManager.userObj = myUserObj
            
        } else {
            print("User")
        }
        
        setIntialMethods()
        
        simpleVideoView.isHidden = true
        
        //        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        //        let player = AVPlayer(url: videoURL!)
        //        let playerController = AVPlayerViewController()
        //        playerController.player = player
        //        self.addChildViewController(playerController)
        //        simpleView.addSubview(playerController.view)
        //        playerController.view.frame = simpleView.frame
        //        simpleView.layoutIfNeeded()
        //        player.play()
        
//        let myVideoURL = NSURL(string: "https://www.youtube.com/watch?v=0wrIcPOwycw")
//        youTubeView.loadVideoURL(myVideoURL! as URL)
        
    }
    
    override var navTitle: String {
        
        return "Setting"
    }
    
    
    override func gotoScanView() {
        
        self.performSegue(withIdentifier: "goto_scanbarcodeview", sender: nil)
    }
    
    override func gotoSettingView() {
        
        self.performSegue(withIdentifier: "goto_settingview", sender: nil)
    }
    
    func setIntialMethods(){
        
        
        setImageGrid = 0
        setPriceGrid = 0
        
        leftTbl.delegate = self
        leftTbl.dataSource = self
        rightTbl.delegate = self
        rightTbl.dataSource = self
        
        leftTbl.register(UINib(nibName: "ItemDetails", bundle: nil), forCellReuseIdentifier: "Cell")
        rightTbl.register(UINib(nibName: "ItemDetails", bundle: nil), forCellReuseIdentifier: "Cell")
        
        leftTbl.estimatedRowHeight = 200.0
        leftTbl.rowHeight = UITableViewAutomaticDimension
        rightTbl.estimatedRowHeight = 200.0
        rightTbl.rowHeight = UITableViewAutomaticDimension
        leftTbl.separatorStyle = .none
        rightTbl.separatorStyle = .none
        leftTbl.tableFooterView = UIView()
        rightTbl.tableFooterView = UIView()
        
       callProductAPI()
       
       getProductsByDay(strDay: "Mon")
    }
    
    func getProductsByDay(strDay : String) {

        ModelManager.sharedInstance.scheduleManager.getSchdulesByDay(strDay: strDay) { (arrSchduleObj, isSuccess, responseMessage) in
            
            print(arrSchduleObj!)
            print("Scheduled videos recieved")
            
        
            var nearestScheduleObj : SchedulerI?
            var miniTime : Double?
            var isVedReceived : Bool = false
            
            for sheObj in arrSchduleObj!
            {
                let tempSchObj = sheObj as SchedulerI
                
                
                let stDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: "04:40PM")
                let endDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: "07:30PM")
                
 
                
                //-------This check Provides us nearest upcoming Ved Refrence
                let startDT = stDate.timeIntervalSince1970
                let currentDT = NSDate().timeIntervalSince1970
                
                let differenceTime = (startDT - currentDT)
                
                if(differenceTime > 0.0)
                {
                    if(miniTime == nil)
                    {
                        miniTime =  differenceTime
                        nearestScheduleObj = tempSchObj
                    }
                    else
                    {
                        if(differenceTime < miniTime!)
                        {
                            miniTime = differenceTime
                            nearestScheduleObj = tempSchObj
                        }
                    }
                }
                //-------
                
                print("\(stDate)")
                 let fallsBetween = (stDate...endDate).contains(Date())
                
                if(fallsBetween)
                {
                    isVedReceived = true
                    
                    self.playVideoInPlayer(strUrl: tempSchObj.productVedUrl!)
                    
                    //Schdule local notification, W.R.T its End Time
                    
                    self.setLocalNotification(notificationDate: endDate)
                    print("time lies in ved Playing time")
                }
            }
            
            if(!isVedReceived)
            {
                let defaultUrl = "www.gmail.com"
                self.playVideoInPlayer(strUrl: defaultUrl)
                
                //Schdule local notification, W.R.T its Start Time
//                let stDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: (nearestScheduleObj?.startTime!)!)
//                
//                self.setLocalNotification(notificationDate: stDate)
                
                
            }
            
        }
        
    }
    
    
    func playVideoInPlayer(strUrl : String)
    {
        youTubeView.clear()

        let myVideoURL = NSURL(string: strUrl)
        youTubeView.loadVideoURL(myVideoURL! as URL)
        
        self.perform(#selector(HomeControl.playVed), with: nil, afterDelay: 10)
    }
    
    func playVed() {
        youTubeView.play()
    }
    
    
    func callProductAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = "8"
        SVProgressHUD.show(withStatus: "Loding.....")
        
        ModelManager.sharedInstance.productManager.getAllProducts(userID: dictData) { (productObj, isSuccess, responseMessage) in
            
            SVProgressHUD.dismiss()
            
            self.productObj = productObj
            
            if productObj.arrProductDesc?.count != 0 {
                
                self.arrProductDes = (productObj.arrProductDesc as! NSMutableArray).mutableCopy() as! NSMutableArray
               
                
                for i in (0..<self.arrProductDes.count){
                    
                    if i % 2 == 0 {
                        
                        self.leftData.add(self.arrProductDes[i])
                        
                    }else{
                        
                        self.rightData.add(self.arrProductDes[i])
                    }
                    
                }
                
                self.setImageGrid = Int(productObj.imageGridRowValue!)
                self.setPriceGrid = Int(productObj.priceGridRowValue!)
                
                self.leftTbl.reloadData()
                self.rightTbl.reloadData()
                
                
            }
            if productObj.arrProductPrice?.count != 0 {
                
                self.arrProductPrice = (productObj.arrProductPrice as! NSMutableArray).mutableCopy() as! NSMutableArray
                self.setPriceGridView(priceItems: self.setPriceGrid!)
            }
        }

    }
    
    func setPriceGridView(priceItems: Int){
        
        //let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let layout = setClv.collectionViewLayout as! UICollectionViewFlowLayout
        
        let setItemsCount:Int = priceItems
        
        print(setItemsCount)
        
        //Get device width
        let width = Int(setClv.frame.width) - setItemsCount*setItemsCount
        
        print((Int(width)/setItemsCount)*setItemsCount)
        
        let setInset = Int(width) - Int(Int(width)/setItemsCount)*setItemsCount
        
        print(setInset)
        
        //set section inset as per your requirement.
        
        layout.sectionInset = UIEdgeInsets(top: CGFloat(setInset/setItemsCount), left: CGFloat(setInset/setItemsCount), bottom: CGFloat(setInset/setItemsCount), right: CGFloat(setInset/setItemsCount))
        
        //set cell item size here
        layout.itemSize = CGSize(width: Int(Int(width)/setItemsCount), height: Int(view.frame.height/7))
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = CGFloat(setItemsCount)
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = CGFloat(setItemsCount)
        
        //apply defined layout to collectionview
        setClv!.collectionViewLayout = layout
        
       // setClv.invalidateIntrinsicContentSize()
        
        setClv.reloadData()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
           return setImageGrid!
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ItemDetails?
        
            if tableView == leftTbl {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ItemDetails
                cell?.selectionStyle = .none
                
                if indexPath.row >= leftData.count {
                    
                    cell?.lbl_ItemTitle.text = ""
                    cell?.lbl_ItemPrice.text = ""
                    
                }else{
                    
                    let proDescObj = leftData[indexPath.row] as! ProductDescI
                    let url = URL(string: proDescObj.productImgUrl!)
                    cell?.ItemImage.af_setImage(withURL: url!)
                    cell?.lbl_ItemTitle.text = proDescObj.productName
                    cell?.lbl_ItemPrice.text = proDescObj.productPrice
                    cell?.setShadow.viewdraw((cell?.setShadow.bounds)!)
                }
                
              
            }
            
            if tableView == rightTbl {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ItemDetails
                cell?.selectionStyle = .none
                
                if indexPath.row >= rightData.count {
                    cell?.lbl_ItemTitle.text = ""
                    cell?.lbl_ItemPrice.text = ""
                    
                }else{
                    
                    let proDescObj = rightData[indexPath.row] as! ProductDescI
                    let url = URL(string: proDescObj.productImgUrl!)
                    cell?.ItemImage.af_setImage(withURL: url!)
                    cell?.lbl_ItemTitle.text = proDescObj.productName
                    cell?.lbl_ItemPrice.text = proDescObj.productPrice
                    cell?.setShadow.viewdraw((cell?.setShadow.bounds)!)
                }
            }
        
        return cell!
    }
    
     public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
        if tableView == leftTbl
        {
            let proDescObj = leftData[indexPath.row] as! ProductDescI
            self.playVideoInPlayer(strUrl: proDescObj.productVedUrl!)
            
        }
        else if tableView == rightTbl {
            
            let proDescObj = rightData[indexPath.row] as! ProductDescI
            self.playVideoInPlayer(strUrl: proDescObj.productVedUrl!)
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(setPriceGrid!)
        
        return setPriceGrid!
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PriceCell
        
        if indexPath.row >= arrProductPrice.count {
            
            cell.lbl_Name.text = ""
            cell.lbl_Price.text = ""
            
        }else{
            
            let proDescObj = arrProductPrice[indexPath.row] as! ProductPriceI
            cell.lbl_Name.text = proDescObj.productName
            cell.lbl_Price.text = proDescObj.productRate
            cell.setShadow.viewdraw(cell.setShadow.bounds)
        }
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Local Notification
    func setLocalNotification(notificationDate : Date)
    {
        let notification = UILocalNotification()
        notification.fireDate = notificationDate
        notification.userInfo = ["UUID": "reminderID" ]
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    func removeNotification(arrNotificationID : [String])
    {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: arrNotificationID)
        } else {
            // Fallback on earlier versions
        }
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
