//
//  PackTableViewCell.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 28/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//

import UIKit

class PackTableViewCell: UITableViewCell {

    @IBOutlet weak var packIconImage: UIImageView!
    @IBOutlet weak var packNameLabel: UILabel!
    @IBOutlet weak var packSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        packNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        packSizeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        packSizeLabel.textColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
