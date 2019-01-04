//
//  FinalsTableViewCell.swift
//  Bruins Den
//
//  Created by Daniel Zamoshchin on 1/2/19.
//  Copyright © 2019 Cherry Creek High School. All rights reserved.
//

import UIKit

class FinalsTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var period: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
