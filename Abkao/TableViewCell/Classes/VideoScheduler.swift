//
//  VideoScheduler.swift
//  Abkao
//
//  Created by Inder on 18/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class VideoScheduler: UITableViewCell {

    
    @IBOutlet weak var lbl_StartTime: UILabel!
    @IBOutlet weak var lbl_EndTime: UILabel!    
    @IBOutlet weak var lbl_VideoURL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
