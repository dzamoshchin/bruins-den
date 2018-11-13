//
//  ClubTableViewCell.swift
//  Clubs
//
//  Created by J Lee on 7/26/17.
//  Copyright © 2017 J Lee. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {
    
    var club: Club?
    @IBOutlet weak var clubName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
