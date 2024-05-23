//
//  getSubGradeCellVC.swift
//  APPlICATION
//
//  Created by Ashish on 22/05/24.
//

import UIKit

class getSubGradeCellVC: UITableViewCell {

    @IBOutlet weak var subGradeCellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        subGradeCellView.layer.cornerRadius = 10
        subGradeCellView.layer.borderWidth = 1
        subGradeCellView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
