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

//MARK: - Local Notification Methods

extension HomeControl:UNUserNotificationCenterDelegate{
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            getDayVideos()
            print("Notification received in foreground")
            completionHandler( [])
            
        }
    }
}


class HomeControl: AbstractControl,UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Local Variables

    var requestIdentifier = ""
    
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
    
    
    //MARK: - Default Methods

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        callProductAPI()
        self.getDayVideos()
        
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
       

        let strDayName = NSDate().dayOfWeek()

       getProductsByDay(strDay: strDayName!)
    }
    
    
    //MARK: - Ved Play Methods
    func getProductsByDay(strDay : String) {
        
        ModelManager.sharedInstance.scheduleManager.dayName = strDay
        
        ModelManager.sharedInstance.scheduleManager.getSchdulesByDay(strDay: "Mon") { (arrSchduleObj, isSuccess, responseMessage) in
            
            print(arrSchduleObj!)
            print("Scheduled videos recieved")
            
            self.getDayVideos()
            
            
        }
        
    }
    
    
    func getDayVideos()
    {
        var nearestScheduleObj : SchedulerI?
        var miniTime : Double?
        var isVedReceived : Bool = false
        
        for sheObj in ModelManager.sharedInstance.scheduleManager.arrDaySchedules!
        {
            let tempSchObj = sheObj as! SchedulerI
            
            let stDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: tempSchObj.startTime!)
            let endDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: tempSchObj.endTime!)
            
            //testing code
//            let stDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: "12:40PM")
//            let endDate = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: "06:44PM")
            
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
            
            //check if end date is greater than current date
            if(endDate.compare(stDate) == .orderedDescending)
            {
                print("Date decending")
                
                let fallsBetween = (stDate...endDate).contains(Date())
                
                if(fallsBetween)
                {
                    isVedReceived = true
                    
                    requestIdentifier = (tempSchObj.scheduleID?.description)!
                    self.removeNotification(arrNotificationID: [requestIdentifier])
                    
                    self.setLocalNotification(shcduleObj: tempSchObj, notificationDate: endDate)
                    
                    self.playVideoInPlayer(strUrl: tempSchObj.productVedUrl!)
                    
                    //Schdule local notification, W.R.T its End Time
                    
                    print("time lies in ved Playing time")
                }
            }
        }
        
        if(!isVedReceived)
        {
            let defaultUrl = ModelManager.sharedInstance.profileManager.userObj?.defaultUrl
            self.playVideoInPlayer(strUrl: defaultUrl!)
            
            
            if(nearestScheduleObj != nil)
            {
                //Schdule local notification, W.R.T its Start Time
                
                let dateObj = NSDate.getDateObj(formaterType: Constants.kDateFormatter, dateString: (nearestScheduleObj?.startTime!)!)

                requestIdentifier = (nearestScheduleObj?.scheduleID?.description)!
                self.removeNotification(arrNotificationID: [requestIdentifier])
                
                self.setLocalNotification(shcduleObj: nearestScheduleObj!, notificationDate: dateObj)
                
            }
        }

    }
    
    
    func playVideoInPlayer(strUrl : String)
    {
        //temp comment

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
            self.leftData.removeAllObjects()
            self.rightData.removeAllObjects()
            self.arrProductPrice.removeAllObjects()
            self.arrProductPrice.removeAllObjects()
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
    func setLocalNotification(shcduleObj : SchedulerI, notificationDate : Date)
    {
        
        print("notification will be triggered in 10 seconds..Hold on tight")
        
        // Deliver the notification in five seconds.
        if #available(iOS 10.0, *) {
            
            let content = UNMutableNotificationContent()
//            content.title = "notification fire time"
//            content.subtitle = "Get Ready"
            content.sound = UNNotificationSound.init(named: "empty.wav")

            content.setValue("YES", forKeyPath: "shouldAlwaysAlertWhileAppIsForeground")
            //content.body = ""
            
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10,
                                                           // repeats: false)
            
            //let date = Date(timeIntervalSinceNow: 10)
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: notificationDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                        repeats: false)
            
            
            requestIdentifier = (shcduleObj.scheduleID?.description)!
            let request = UNNotificationRequest(identifier: requestIdentifier,  content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().delegate = self
            
            UNUserNotificationCenter.current().add(request){(error) in
                
                if (error != nil){
                    
                    //print(error?.localizedDescription)
                    print("Something went wrong: ")

                }
            }
        } else {
            // Fallback on earlier versions
        }
        
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
