//
//  VideoPlayerViewController.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerView: UIView {
    
    var itemURL: URL?
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
