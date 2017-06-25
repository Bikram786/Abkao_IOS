//
//  ImageCellControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class ImageCellControl: AbstractControl ,UITableViewDelegate, UITableViewDataSource{
    
    
    var getImageGridValue:Int?
    var productObj : ImageCelll?
    var arrProductImages = NSMutableArray()
    
    @IBOutlet weak var imageControlTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageControlTbl.delegate = self
        imageControlTbl.dataSource = self
        imageControlTbl.register(UINib(nibName: "ImageControl", bundle: nil), forCellReuseIdentifier: "ImageControl")
        imageControlTbl.estimatedRowHeight = 50.0
        imageControlTbl.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callProductAPI()
    }

    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    func callProductAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = "8"
        
        ModelManager.sharedInstance.imageCellManager.getAllRecords(userID: dictData) { (productObj, isSuccess, responseMessage) in
            
            print(productObj)
            
            self.arrProductImages.removeAllObjects()
            self.productObj = productObj
            self.arrProductImages = (productObj.arrProductImage as! NSMutableArray).mutableCopy() as! NSMutableArray
            print(self.arrProductImages)
            self.imageControlTbl.reloadData()
            
        }
        
    }
    
    func callProductDeleteAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["product_id"] = "2"
        dictData["userid"] = "8"
        
        ModelManager.sharedInstance.imageCellManager.deleteRecord(userInfo: dictData) { (productObj, isSuccess, responseMessage) in
            
        }
        
    }
    
    func callProductupdateAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = "8"
        
        ModelManager.sharedInstance.imageCellManager.updateRecord(userInfo: dictData) { (productObj, isSuccess, responseMessage) in
//            self.arrProductPrice.removeAllObjects()
//            self.productObj = productObj
//            self.arrProductPrice = (productObj.arrProductPrice as! NSMutableArray).mutableCopy() as! NSMutableArray
//            self.priceTable.reloadData()
            
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
        let url = URL(string: proDescObj.productImgUrl!)
        cell.setImage.af_setImage(withURL: url!)
        cell.lbl_ProductName.text = proDescObj.productName!
        cell.lbl_ProductPrice.text = proDescObj.productPrice!
        cell.lbl_VideoURL.text = proDescObj.productPrice!
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
        editAction.backgroundColor = .blue
    
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
    
    //self.callProductDeleteAPI(productID: proDescObj.productID!)
    
    }
    deleteAction.backgroundColor = .red
    
    return [editAction,deleteAction]
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
