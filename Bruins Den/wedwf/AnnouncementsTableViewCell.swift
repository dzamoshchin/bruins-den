//
//  AnnouncementsTableViewCell.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 8/2/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class AnnouncementsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var heading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
