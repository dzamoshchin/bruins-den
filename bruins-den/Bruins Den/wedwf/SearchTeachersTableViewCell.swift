//
//  SearchTeachersTableViewCell.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/25/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class SearchTeachersTableViewCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        pic.layer.borderWidth = 1
        pic.layer.masksToBounds = false
        pic.layer.borderColor = UIColor.black.cgColor
        pic.layer.cornerRadius = pic.frame.height/2
        pic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
