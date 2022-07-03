//
//  DrinkMemoryTableViewCell.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/22.
//

import UIKit

class DrinkMemoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var cellBackGroundView: UIView!
    @IBOutlet private weak var editorNameLabel: UILabel!
    @IBOutlet private weak var drinkNameLabel: UILabel!
    @IBOutlet private weak var drinkFeatureLabel: UILabel!
    @IBOutlet private weak var detailButton: UIButton!
    @IBOutlet private weak var drinkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
