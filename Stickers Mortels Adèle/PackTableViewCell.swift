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
    @IBOutlet weak var plusBtn: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        packNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        packSizeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        packSizeLabel.textColor = .gray
        if #available(iOS 13.0, *) {
            plusBtn.image = UIImage(systemName: "plus")
        } else {
            plusBtn.image = UIImage(named: "addicn")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
