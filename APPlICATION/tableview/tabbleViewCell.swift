//
//  tabbleViewCell.swift
//  APPlICATION
//
//  Created by Ashish on 22/05/24.
//

import UIKit

class tabbleViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
