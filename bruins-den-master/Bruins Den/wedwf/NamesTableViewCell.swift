//
//  NamesTableViewCell.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 10/7/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class NamesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
