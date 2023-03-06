//
//  YoutubeAPIResultTableViewCell.swift
//  Drinto
//
//  Created by HiroakiSaito on 2023/03/06.
//

import UIKit

class YoutubeAPIResultTableViewCell: UITableViewCell {
    @IBOutlet weak var ThumbnailImageView: UIImageView!
    @IBOutlet weak var youtubeTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
