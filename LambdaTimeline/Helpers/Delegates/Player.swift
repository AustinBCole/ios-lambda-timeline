//
//  Player.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerDelegate: AnyObject, AVAudioPlayerDelegate {
    func playerDidChangeState(_ player: Player)
}

///Delegate of the Audio Player.
class Player: NSObject {
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    weak var delegate: PlayerDelegate?
    
    ///Indicates whether or not the audio player is playing
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    ///Indicates how much time has elapsed since the beginning of the recording
    var elapstedTime: TimeInterval {
        return audioPlayer?.currentTime ?? 0
    }
    
    /**
     If the audio player is playing, we will pause. If the audio player is paused, we will play.
     
     - Parameter audioFile: The url to the audio file you wish to play.
     */
    func playPause(audioFile: URL) {
        if isPlaying {
            play(audioFile: audioFile)
        }
    }
    /**
     Instructs the audioPlayer to play. If the audioPlayer does not exist, it is created.
     
     ## Important Note ##
     
     The audioFile parameter is **not** optional. It is assumed that there will **always** be a file inputted.
     
     - Parameter audioFile: The url to the audio file you wish to play.
     */
    func play(audioFile: URL) {

        if audioPlayer?.url != audioFile || audioPlayer == nil {
            audioPlayer = try! AVAudioPlayer(contentsOf: audioFile)
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
        }
        audioPlayer?.play()
        notifyDelegate()
    }
    
    /**
     Converts the audio file data into the audio file URL necessary to play the audio. The method takes a data parameter and returns a URL.
     
     - Parameter data: The data that will be used to get the desired URL path.
     */
    func getAudioFile(fromData data: Data) -> URL {
        return URL(dataRepresentation: data, relativeTo: nil)!
    }
    
    //MARK: Private Methods
    
    ///Instructs the audioPlayer to pause
    private func pause() {
        audioPlayer?.pause()
        notifyDelegate()
    }
    
    ///Notify the delegate when the audio player changes state
    private func notifyDelegate() {
        delegate?.playerDidChangeState(self)
    }
}
