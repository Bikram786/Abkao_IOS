//
//  VideoSchedulerControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class VideoSchedulerControl: AbstractControl,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var VideoSchedulerTable: UITableView!
    
    
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

    override var navTitle: String{
        return "Logout"
    }
    
    override func gotoLoginView() {
        
    }
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        // This is where you would change section header content
        return tableView.dequeueReusableCell(withIdentifier: "VideoSchedulerHeader")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoScheduler", for: indexPath) as! VideoScheduler
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
