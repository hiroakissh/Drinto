//
//  DrinkMemoryTableViewCell.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/05/22.
//

import UIKit

class DrinkMemoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var cellBackGroundView: UIView!
    @IBOutlet private(set) weak var editorNameLabel: UILabel!
    @IBOutlet private(set) weak var drinkNameLabel: UILabel!
    @IBOutlet private(set) weak var drinkFeatureLabel: UILabel!
    @IBOutlet private(set) weak var categoryLabel: UILabel!
    @IBOutlet private(set) weak var featureLabel: UILabel!
    @IBOutlet private(set) weak var drinkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        cellBackGroundView.layer.cornerRadius = 10.0
        cellBackGroundView.layer.shadowOffset = .init(width: 0.25, height: 0.25)
        cellBackGroundView.layer.shadowOpacity = 0.5
        cellBackGroundView.layer.shadowRadius = 10.0
        categoryLabel.layer.cornerRadius = 10.0
        categoryLabel.clipsToBounds = true
        drinkImageView.clipsToBounds = true
        drinkImageView.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
