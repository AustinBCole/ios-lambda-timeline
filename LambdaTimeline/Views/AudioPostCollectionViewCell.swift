//
//  AudioPostCollectionViewCell.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AudioPostCollectionViewCell: UICollectionViewCell {
    //MARK: Private Properties
    var audioFile: URL?
    private let audioPlayer = Player()
    //MARK: IBOutlets
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playAudioButton: UIButton!
    
    @IBAction func playAudioButtonWasTapped(_ sender: Any) {
        audioPlayer.play(audioFile: audioFile!)
    }
    
    
    
}
