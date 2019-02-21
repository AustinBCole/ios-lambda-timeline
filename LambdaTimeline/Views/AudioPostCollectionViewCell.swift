//
//  AudioPostCollectionViewCell.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AudioPostCollectionViewCell: UICollectionViewCell, PlayerDelegate {
    
    var audioFile: URL?
    var post: Post?
    
    //MARK: Private Properties
    var audioPlayer: Player?
    
    //MARK: IBOutlets
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playAudioButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: IBActions
    @IBAction func playAudioButtonWasTapped(_ sender: Any) {
        audioPlayer?.playPause(audioFile: audioFile!)
        updateViews()
    }
    
    //MARK: Delegate Methods
    func playerDidChangeState(_ player: Player) {
        updateViews()
    }
    
    //MARK: Private Methods
    private func updateViews() {
        let isPlaying = audioPlayer?.isPlaying
        playAudioButton.setTitle(isPlaying! ? "Pause Audio" : "Play Audio"
            , for: .normal)
    }
    
    
    
}
