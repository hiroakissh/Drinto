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

        cellBackGroundView.layer.cornerRadius = 20.0
        cellBackGroundView.layer.shadowOffset = .init(width: 0.25, height: 0.25)
        cellBackGroundView.layer.shadowOpacity = 0.3
        cellBackGroundView.layer.shadowRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
