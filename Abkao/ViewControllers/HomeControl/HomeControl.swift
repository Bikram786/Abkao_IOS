//
//  HomeControl.swift
//  Abkao
//
//  Created by Inder on 10/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class HomeControl: AbstractControl,UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var setClv: UICollectionView!
    @IBOutlet weak var leftTbl: UITableView!
    @IBOutlet weak var rightTbl: UITableView!
    
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
        
        setIntialMethods()
        
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
    }
    
    
    func callProductAPI(){
        
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = "5"
        
        ModelManager.sharedInstance.productManager.getAllProducts(userID: dictData) { (productObj, isSuccess, responseMessage) in
            
            self.productObj = productObj
            
            if productObj.arrProductDesc?.count != 0 {
                
                self.arrProductDes = (productObj.arrProductDesc as! NSMutableArray).mutableCopy() as! NSMutableArray
                self.arrProductPrice = (productObj.arrProductPrice as! NSMutableArray).mutableCopy() as! NSMutableArray
                
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
                
                if indexPath.row >= leftData.count {
                    
                    cell?.lbl_ItemTitle.text = ""
                    cell?.lbl_ItemPrice.text = ""
                    
                }else{
                    
                    let proDescObj = leftData[indexPath.row] as! ProductDescI
                    
                    //cell.ItemImage.image = #imageLiteral(resourceName: "test")
                    cell?.lbl_ItemTitle.text = proDescObj.productName
                    cell?.lbl_ItemPrice.text = proDescObj.productPrice
                    cell?.setShadow.viewdraw((cell?.setShadow.bounds)!)
                }
                
              
            }
            
            if tableView == rightTbl {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ItemDetails
                
                if indexPath.row >= rightData.count {
                    cell?.lbl_ItemTitle.text = ""
                    cell?.lbl_ItemPrice.text = ""
                    
                }else{
                    
                    let proDescObj = rightData[indexPath.row] as! ProductDescI
                    
                    //cell.ItemImage.image = #imageLiteral(resourceName: "test")
                    cell?.lbl_ItemTitle.text = proDescObj.productName
                    cell?.lbl_ItemPrice.text = proDescObj.productPrice
                    cell?.setShadow.viewdraw((cell?.setShadow.bounds)!)
                }
                
            }
        
        
        return cell!
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return setPriceGrid!
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PriceCell
        let proDescObj = arrProductPrice[indexPath.row] as! ProductPriceI
        cell.lbl_Name.text = proDescObj.productName
        cell.lbl_Price.text = proDescObj.productRate
        cell.setShadow.viewdraw(cell.setShadow.bounds)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
