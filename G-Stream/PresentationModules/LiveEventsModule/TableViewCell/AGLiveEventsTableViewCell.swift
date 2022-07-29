//
//  AGLiveTableViewCell.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import UIKit

class AGEventsLiveTableViewCell: UITableViewCell {

    @IBOutlet var leagueImage: UIImageView!
    @IBOutlet var teams: UILabel!
    @IBOutlet var league: UILabel!
    @IBOutlet var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
