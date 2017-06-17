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
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4","1", "2", "3", "4",""]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = setClv.frame.width - 6
        
        let setItemsCount = 3
        
        print((Int(width)/setItemsCount)*setItemsCount)
        
        let setInset = Int(width) - Int(Int(width)/setItemsCount)*setItemsCount
        
        print(setInset)
        
        //set section inset as per your requirement.
        
        layout.sectionInset = UIEdgeInsets(top: CGFloat(setInset/setItemsCount), left: CGFloat(setInset/setItemsCount), bottom: CGFloat(setInset/setItemsCount), right: CGFloat(setInset/setItemsCount))
        
        //set cell item size here
        layout.itemSize = CGSize(width: Int(width)/setItemsCount , height: Int(width)/setItemsCount)
        
        //set Minimum spacing between 2 items
        layout.minimumInteritemSpacing = 3
        
        //set minimum vertical line spacing here between two lines in collectionview
        layout.minimumLineSpacing = 3
        
        //apply defined layout to collectionview
        setClv!.collectionViewLayout = layout
    }
    
    override var navTitle: String {
        
        return "Setting"
    }
    
    //    override var showLeft: Bool{
    //        return false
    //    }
    //
    //    override var showLeftSetting: Bool{
    //
    //        return true
    //    }
    
    
    
    override func gotoScanView() {
        
        self.performSegue(withIdentifier: "goto_scanbarcodeview", sender: nil)
    }
    
    override func gotoSettingView() {
        
        self.performSegue(withIdentifier: "goto_settingview", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemDetails
        cell.ItemImage.image = #imageLiteral(resourceName: "test")
        cell.lbl_ItemTitle.text = "Bikram"
        cell.lbl_ItemPrice.text = "5.0"
        cell.setShadow.viewdraw(cell.setShadow.bounds)
        return cell
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PriceCell
        cell.lbl_Name.text = "Bikram"
        cell.lbl_Price.text = "5.0"
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
