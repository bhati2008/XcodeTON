//
//  GraphtDataCell.swift
//  APPlICATION
//
//  Created by Ashish on 03/04/24.
//

import UIKit

class GraphtDataCell: UITableViewCell {

    @IBOutlet weak var graphCellView: UIView!
    @IBOutlet weak var RateLbl: UILabel!
    @IBOutlet weak var RateDiffrenceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        graphCellView.layer.cornerRadius = 10
        graphCellView.layer.borderWidth = 1
        graphCellView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
