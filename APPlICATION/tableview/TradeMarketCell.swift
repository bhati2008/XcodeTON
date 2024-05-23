//
//  TradeMarketCell.swift
//  APPlICATION
//
//  Created by Ashish on 31/03/24.
//

import UIKit

class TradeMarketCell: UITableViewCell {


    @IBOutlet weak var tradeMarketcellView: UIView!
    @IBOutlet weak var RateLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        tradeMarketcellView.layer.cornerRadius = 10
        tradeMarketcellView.layer.borderWidth = 1
        tradeMarketcellView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
