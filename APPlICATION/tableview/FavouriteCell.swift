//
//  FavouriteCell.swift
//  APPlICATION
//
//  Created by Ashish on 26/04/24.
//

import UIKit
import Charts

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var lineChartView: LineChartView!

    @IBOutlet weak var tradeName: UILabel!
    
    @IBOutlet weak var rateChange: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tradeGradeName: UILabel!
    @IBOutlet weak var subTradeName: UILabel!
    @IBOutlet weak var marketName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
