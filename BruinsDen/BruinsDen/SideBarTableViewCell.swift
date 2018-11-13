//
//  SideBarTableViewCell.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 6/2/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class SideBarTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
