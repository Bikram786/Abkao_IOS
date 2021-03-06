//
//  ImageCellControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class ImageCellControl: AbstractControl ,UITableViewDelegate, UITableViewDataSource{
    
    
    var getImageGridValue:Int?
//    var productObj : ImageCelll?
    var arrProductImages = NSMutableArray()
    @IBOutlet weak var imageControlTbl: UITableView!    
    @IBOutlet weak var btn_AddMore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageControlTbl.delegate = self
        imageControlTbl.dataSource = self
        imageControlTbl.register(UINib(nibName: "ImageControl", bundle: nil), forCellReuseIdentifier: "ImageControl")
        imageControlTbl.estimatedRowHeight = 50.0
        imageControlTbl.rowHeight = UITableViewAutomaticDimension
        imageControlTbl.separatorStyle = .none
        imageControlTbl.tableFooterView = UIView()
        self.btn_AddMore.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        callProductAPI()
        
    }

    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    func callProductAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        SVProgressHUD.show(withStatus: "Loading.....")
        ModelManager.sharedInstance.imageCellManager.getAllRecords(userID: dictData) { (arrProductObj, isSuccess, responseMessage) in
            SVProgressHUD.dismiss()
            if(isSuccess){
                self.arrProductImages.removeAllObjects()
//                self.productObj = productObj
                self.arrProductImages = (arrProductObj as! NSMutableArray).mutableCopy() as! NSMutableArray
                let setItemCount = self.getImageGridValue! - self.arrProductImages.count
                if setItemCount > 0{
                    self.btn_AddMore.isHidden = false
                    let setCount = "Add " + String(setItemCount) + " More"
                    self.btn_AddMore.setTitle(setCount, for: .normal)
                }
                else
                {
                    self.btn_AddMore.isHidden = true
                    
                }
                
                self.imageControlTbl.reloadData()
            }else{
                SVProgressHUD.showError(withStatus: responseMessage)
            }
            
        }
        
    }
    
    func callProductDeleteAPI(productID: String){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["product_id"] = productID
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        SVProgressHUD.show(withStatus: "Loading.....")
        ModelManager.sharedInstance.imageCellManager.deleteRecord(userInfo: dictData) { (productObj, isSuccess, responseMessage) in
            
            SVProgressHUD.dismiss()
            if(isSuccess){
                self.callProductAPI()
            }else{
                SVProgressHUD.showError(withStatus: responseMessage)
            }
            
        }
        
    }
    
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageControl", for: indexPath) as! ImageControl
        cell.selectionStyle = .none
        let proDescObj = arrProductImages[indexPath.row] as! ProductDescI
        cell.setImageView.setViewBoarder()
        
        self.removeCacheForHomeContentImage(url: proDescObj.productImgUrl!)
        
        let url = URL(string: proDescObj.productImgUrl!)
        
        cell.setImage.af_setImage(withURL: url!)
        
        cell.lbl_ProductName.text = proDescObj.productName!.capitalized
        cell.lbl_ProductPrice.text = "$ \(String(describing: proDescObj.productPrice!))"
        cell.lbl_VideoURL.text = proDescObj.productVedUrl!
        
        cell.lbl_ProductName.font = UIFont(name: "Cormorant-Bold", size: CGFloat(Constants.appFontSize.regularFont))
        cell.lbl_ProductPrice.font = UIFont(name: "Cormorant-Regular", size: CGFloat(Constants.appFontSize.smallFont))
        cell.lbl_VideoURL.font = UIFont(name: "Cormorant-Regular", size: CGFloat(Constants.appFontSize.smallFont))

        //cell.productNameView.setViewBoarder()
        //cell.productPriceView.setViewBoarder()
        //cell.productURLView.setViewBoarder()
        
        return cell
        
    }
    
    


    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
        let proDescObj = arrProductImages[indexPath.row] as! ProductDescI
    
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
    
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageItemControl") as! ImageItemControl
            myVC.getPreviousProducts = proDescObj
            myVC.status = "edit"
            self.navigationController?.pushViewController(myVC, animated: true)
    
    
        }
        editAction.backgroundColor = Constants.appColor.appEditColor
    
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
    
        self.callProductDeleteAPI(productID: String(proDescObj.productID!))
    
    }
    deleteAction.backgroundColor = Constants.appColor.appDeleteColor
    
    return [editAction,deleteAction]
    }
    
    // MARK: - Custom Methods
    
    func removeCacheForHomeContentImage(url: String) {
        let imageURL = URL(string : url)
        let urlRequest = Foundation.URLRequest(url: imageURL!)
        
        let imageDownloader = UIImageView.af_sharedImageDownloader
        
        // Clear the URLRequest from the in-memory cache
        _ = imageDownloader.imageCache?.removeImage(for: urlRequest, withIdentifier: nil)
        // Clear the URLRequest from the on-disk cache
        
        imageDownloader.sessionManager.session.configuration.urlCache?.removeCachedResponse(for: urlRequest)
    }
    
    // MARK: - Default methods

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
