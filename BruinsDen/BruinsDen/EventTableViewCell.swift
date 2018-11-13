//
//  EventTableViewCell.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 6/24/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var eventName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
