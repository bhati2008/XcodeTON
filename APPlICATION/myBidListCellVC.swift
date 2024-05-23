//
//  myBidListCellVC.swift
//  APPlICATION
//
//  Created by Ashish on 20/05/24.
//

import UIKit

class myBidListCellVC: UITableViewCell {

    @IBOutlet weak var bidListImage: UIImageView!
    @IBOutlet weak var item_Title: UILabel!
    @IBOutlet weak var bid_amount: UILabel!
    @IBOutlet weak var bidCount: UILabel!
    @IBOutlet weak var listing_Created_on: UILabel!
    @IBOutlet weak var bidTime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
