//
//  PriceGridControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class PriceGridControl: AbstractControl,UITableViewDelegate, UITableViewDataSource {
    
    var productObj : PriceCelll?
    var getPriceGridValue:Int?
    var arrProductPrice = NSMutableArray()
    
    @IBOutlet weak var priceTable: UITableView!
    @IBOutlet weak var setBoarderView: UIView!
    @IBOutlet weak var btn_ShowItems: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceTable.delegate = self
        priceTable.dataSource = self
        priceTable.register(UINib(nibName: "PriceGrid", bundle: nil), forCellReuseIdentifier: "PriceGrid")
        priceTable.estimatedRowHeight = 100
        priceTable.rowHeight = UITableViewAutomaticDimension
        priceTable.separatorStyle = .none
        priceTable.tableFooterView = UIView()
        setBoarderView.viewdraw(setBoarderView.bounds)
        let setValue = "Add " + String(getPriceGridValue!*getPriceGridValue!) + " Items"
        btn_ShowItems.setTitle(setValue, for: .normal)
        
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
        
        ModelManager.sharedInstance.priceCellManager.getAllRecords(userID: dictData) { (productObj, isSuccess, responseMessage) in
            
            print(productObj)
            
            self.arrProductPrice.removeAllObjects()
            self.productObj = productObj
            self.arrProductPrice = (productObj.arrProductPrice as! NSMutableArray).mutableCopy() as! NSMutableArray
            self.priceTable.reloadData()
            
        }
        
    }
    
    func callProductDeleteAPI(productID: Int){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["product_id"] = String(productID)
        dictData["userid"] = "5"
        
        ModelManager.sharedInstance.priceCellManager.deleteRecord(userInfo: dictData) { (isSuccess, responseMessage) in
            
            self.callProductAPI()
        }
        
    }
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrProductPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceGrid", for: indexPath) as! PriceGrid
        cell.selectionStyle = .none
        let proDescObj = arrProductPrice[indexPath.row] as! ProductPriceI
        cell.lbl_ProductName.text = proDescObj.productName
        cell.productNameView.setViewBoarder()
        cell.lbl_ProductPrice.text = proDescObj.productRate
        cell.productPriceView.setViewBoarder()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let proDescObj = arrProductPrice[indexPath.row] as! ProductPriceI
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            
            let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PriceItemControl") as! PriceItemControl
            myVC.getPreviousProducts = proDescObj
            myVC.status = "edit"
            self.navigationController?.pushViewController(myVC, animated: true)
            
        }
        editAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            
            self.callProductDeleteAPI(productID: proDescObj.productID!)
            
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
