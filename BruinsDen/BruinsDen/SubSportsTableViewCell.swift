//
//  SubSportsTableViewCell.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/25/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class SubSportsTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    var sport : Sport?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        icon.image = sport?.icon
        name.text = sport?.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
