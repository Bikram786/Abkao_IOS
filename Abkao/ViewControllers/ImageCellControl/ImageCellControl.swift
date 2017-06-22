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
        dictData["userid"] = "5"
        
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
        dictData["userid"] = "5"
        
        ModelManager.sharedInstance.imageCellManager.deleteRecord(userInfo: dictData) { (productObj, isSuccess, responseMessage) in
            
        }
        
    }
    
    func callProductupdateAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = "5"
        
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
        let proDescObj = arrProductImages[indexPath.row] as! ProductDescI
        
        print(proDescObj.productPrice!)
        print(proDescObj.productID!)
        print(proDescObj.productName!)
        
        //cell.lbl_ProductName.text = proDescObj.productName!
        //cell.lbl_ProductPrice.text = proDescObj.productPrice!
        return cell
        
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
