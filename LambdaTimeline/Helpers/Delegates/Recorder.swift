//
//  Record.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import AVFoundation

protocol RecorderDelegate: AnyObject {
    func recorderDidChangeState(_ recorder: Recorder)
}

///Delegate of the audioRecorder
class Recorder: NSObject {
    //MARK: Private Properties
    private var audioRecorder: AVAudioRecorder?
    
    ///The most current audio file made from the user's recording. This is the only audio file that may be posted.
    var currentFile: URL?

    ///Returns the time elapsed since the start of the current recording.
    var elapsedTime: TimeInterval {
        return audioRecorder?.currentTime ?? 0
    }
    
    ///Indicate whether the audioRecorder is currently recording
    var isRecording: Bool {
        return audioRecorder?.isRecording ?? false
    }

    weak var delegate: RecorderDelegate?
    
    /**
     If the audioRecorder is currently recording, the audioRecorder will stop. If not, then it will begin recording.
     
     ## Important Note ##
     
     If the user elects to stop the recording and then begins to record again, the **only recording** that may be posted to the timeline is **the most current**.
 */
    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            record()
        }
    }
    //This method deletes the most recent audio file recorded by the user.
    func cancelRecording() {
        currentFile = nil
    }
    //MARK: Private Methods
    //Create the file path to store the recording and then begin to record. The file path is stored in the `currentFile` property for easy access in case the user decides to cancel.
    private func record() {

        let fm = FileManager.default
        
        //Locate and create the specified common directory in a domain.
        let docs = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let name = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)
        
        //Form URL
        let file = docs.appendingPathComponent(name).appendingPathExtension("caf")
        
        //sample rate is how many times per second is this audio data going to contain a piece of information, a standard audio recording tha tyou might find uses about 44k samples per second. Channels is mono audio versus stereo versus surround sound etc.
        let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!
        
        //for URL we need a way to create a new URL, we will use file manager
        audioRecorder = try! AVAudioRecorder(url: file, format: format)
        //Store the file into the currentFile property for ease of cancelletion
        currentFile = file
        
        audioRecorder?.record()
        notifyDelegate()

    }
    //Stops recording. This method will also set the audioRecorder to nil, allowing the user to make a new recording should the user tap the record button again.
    private func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        notifyDelegate()
        
    }
    
    private func notifyDelegate() {
        delegate?.recorderDidChangeState(self)
    }
}
