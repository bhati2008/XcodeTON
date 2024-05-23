//
//  homeControllereCellVC.swift
//  APPlICATION
//
//  Created by Ashish on 22/05/24.
//

import UIKit

class homeControllereCellVC: UITableViewCell {

    @IBOutlet weak var subtradeCellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        subtradeCellView.layer.cornerRadius = 10
        subtradeCellView.layer.borderWidth = 1
        subtradeCellView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
