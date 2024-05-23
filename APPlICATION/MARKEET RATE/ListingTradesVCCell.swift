//
//  ListingTradesVCCell.swift
//  APPlICATION
//
//  Created by Ashish on 06/04/24.
//

import UIKit

class ListingTradesVCCell: UITableViewCell {
    
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var itemLocation: UILabel!
    @IBOutlet weak var tradeGradeName: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ViewCell.layer.cornerRadius = 10
        ViewCell.layer.borderWidth = 1
        ViewCell.layer.borderColor = UIColor.gray.cgColor
        itemImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
