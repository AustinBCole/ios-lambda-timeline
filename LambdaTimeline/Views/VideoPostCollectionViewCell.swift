//
//  VideoPostCollectionViewCell.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import AVKit

class VideoPostCollectionViewCell: UICollectionViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: AVPlayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
