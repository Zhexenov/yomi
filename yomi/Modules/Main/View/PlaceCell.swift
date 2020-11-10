//
//  PlaceCell.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import UIKit

class PlaceCell : UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var place: Place? {
        didSet {
            nameLabel.text = place?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
