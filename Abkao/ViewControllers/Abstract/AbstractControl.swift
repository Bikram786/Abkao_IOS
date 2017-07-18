//
//  AbstractControl.swift
//  Abkao
//
//  Created by CSPC162 on 09/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class AbstractControl: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        setNavigationBar()
        
        //---------
    }
    
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    // MARK : - Set Custom Navigation Bar
    
    func setNavigationBar() {
        var leftItem: UIBarButtonItem!
        self.navigationItem.title = navTitle
        if navTitle == "Setting" {
            leftItem = UIBarButtonItem(customView: leftSettingBtn)
            self.navigationItem.setLeftBarButton(leftItem, animated: true)
        }
        else if navTitle == "Back"{
            leftItem = UIBarButtonItem(customView: leftSettingBtn)
            self.navigationItem.setLeftBarButton(leftItem, animated: true)
        }
        else{
            leftItem = UIBarButtonItem(customView: leftBackView)
            self.navigationItem.setLeftBarButton(leftItem, animated: true)
        }
        var rightItem: UIBarButtonItem!
        if navTitle == "Logout"{
            rightItem = UIBarButtonItem(customView: logoutBtn)
        }else{
            rightItem = UIBarButtonItem(customView: rightBtn)
        }
        self.navigationItem.setRightBarButton(rightItem, animated: true)
        self.navigationItem.titleView = centerImage
    }
    
    // MARK : - Set Custom Navigation Bar
    
    var _centerImage: UIImageView!
    var centerImage: UIImageView {
        get{
            if _centerImage == nil {
                _centerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                _centerImage.image = #imageLiteral(resourceName: "logo")
                _centerImage.contentMode  = .scaleAspectFit
            }
            return _centerImage
        }set{
            _centerImage = newValue
        }
    }
    
    var _leftBackView: UIView!
    var leftBackView: UIView {
        get {
            if _leftBackView == nil{
                
                
                _leftBackView = UIView()
                _leftBackView.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                _leftBackView.backgroundColor = .white
                _leftBackView.isHidden = !showLeft
                let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
                titleLabel.text = "BACK"
                titleLabel.textColor = .black
                titleLabel.textAlignment = .center
                _leftBackView.viewdraw(_leftBackView.bounds)
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                _leftBackView.addGestureRecognizer(tap)
                _leftBackView.isUserInteractionEnabled = true
                _leftBackView.addSubview(titleLabel)
                
            }
            return _leftBackView
            
        }set{
            
            _leftBackView = newValue
        }
    }
    
    var _leftSettingBtn: UIButton!
    var leftSettingBtn: UIButton {
        get {
            if _leftSettingBtn == nil{
                
                _leftSettingBtn = UIButton(type: .custom)
                _leftSettingBtn.setImage(#imageLiteral(resourceName: "setting"), for: .normal)
                _leftSettingBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
                let longGesture = UILongPressGestureRecognizer(target: self, action: Selector(("longTap:")))
                _leftSettingBtn.addGestureRecognizer(longGesture)
                //_leftSettingBtn.addTarget(self, action: #selector(gotoSettingView), for: .touchUpInside)
                _leftSettingBtn.isHidden = !showLeftSetting
            }
            return _leftSettingBtn
            
        }set{
            
            _leftSettingBtn = newValue
        }
    }
    
    var _rightBtn: UIButton!
    var rightBtn: UIButton {
        
        get{
            
            if _rightBtn == nil{
                
                _rightBtn = UIButton(type: .custom)
                _rightBtn.setImage(#imageLiteral(resourceName: "barcode"), for: .normal)
                _rightBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                _rightBtn.addTarget(self, action: #selector(gotoScanView), for: .touchUpInside)
                _rightBtn.isHidden = !showRight
            }
            return _rightBtn
        } set {
            
            _rightBtn = newValue
        }
    }
    
    var _logoutBtn: UIButton!
    var logoutBtn: UIButton {
        
        get{
            
            if _logoutBtn == nil{
                
                _logoutBtn = UIButton(type: .custom)
                _logoutBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
                _logoutBtn.setTitle("LOGOUT", for: .normal)
                _logoutBtn.titleLabel!.font =  UIFont(name: "Cormorant-Regular", size: 17)
                _logoutBtn.tintColor = .white
                _logoutBtn.backgroundColor = UIColor.init(red: 42.0/255.0, green: 21.0/255.0, blue: 119.0/255.0, alpha: 1)
                _logoutBtn.addTarget(self, action: #selector(gotoLoginView), for: .touchUpInside)
                _logoutBtn.isHidden = !showLogout
            }
            return _logoutBtn
        } set {
            
            _logoutBtn = newValue
        }
    }
    
    var navTitle: String {
        return ""
    }
    
    var showLeft: Bool {
        return true
    }
    
    var showLeftSetting: Bool {
        return true
    }
    
    var showRight: Bool {
        return true
    }
    
    var showLogout: Bool {
        return true
    }
    
    // function which is triggered when handleTap is called
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK : - Navigation Bar Action Methods
    
    func gotoScanView() {
        
    }
    
    func gotoSettingView() {
        
    }
    
    func longTap(_ sender: UIGestureRecognizer){
       
        if sender.state == .began {
            
        }
    }
    
    func gotoLoginView() {
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        SVProgressHUD.show(withStatus: "Loading.....")
        ModelManager.sharedInstance.authManager.logout(userInfo: dictData) { (isSuccess, strMessage) in
            SVProgressHUD.dismiss()
            if(isSuccess)
            {
                UserDefaults.standard.removeObject(forKey: "userinfo")
                UserDefaults.standard.synchronize()
                SVProgressHUD.showError(withStatus: strMessage)
                _ = self.navigationController?.popToRootViewController(animated: true)
            }else{
                
                SVProgressHUD.showError(withStatus: strMessage)
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
