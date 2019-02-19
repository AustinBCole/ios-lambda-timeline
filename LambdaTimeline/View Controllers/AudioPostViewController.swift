//
//  AudioPostViewController.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPostViewController: UIViewController, RecorderDelegate {
    //MARK: Private Properties
    private let audioRecorder = Recorder()
    private let postController = PostController()
    //
    private lazy var timeFormatter: DateComponentsFormatter = {
        let f = DateComponentsFormatter()
        //With this style, the hours/minutes/seconds will be seperated by colons
        f.unitsStyle = .positional
        //This formatting behavior will "pad zeroes as appropriate", meaning that zeroes will not be omitted where relevant
        f.zeroFormattingBehavior = .pad
        //The units allowed to show
        f.allowedUnits = [.minute, .second]
        return f
    }()
    
    //MARK: IBOutlets
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: IBActions
    @IBAction func recordButtonWasTapped(_ sender: Any) {
        audioRecorder.toggleRecording()
    }
    
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        audioRecorder.cancelRecording()
    }
    
    @IBAction func createPost(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let audioFile = audioRecorder.currentFile else {
                presentInformationalAlertController(title: "Uh-oh", message: "Make sure that you make a recording before posting. If you cancelled your recording then you will have to record again.")
                return
        }
        
        let audioData = try! Data(contentsOf: audioFile)
        let title = "Audio Comment"
        
        postController.createPost(with: title, ofType: .audio, mediaData: audioData, ratio: nil) { (success) in
            guard success else {
                DispatchQueue.main.async {
                    self.presentInformationalAlertController(title: "Error", message: "Unable to create post. Try again.")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    //MARK: Delegate Methods
    func recorderDidChangeState(_ recorder: Recorder) {
        updateViews()
    }
    
    //MARK: Private Methods
    private func updateViews() {
        let isRecording = audioRecorder.isRecording
        recordButton.setTitle(isRecording ? "Stop Recording" : "Record"
            , for: .normal)
        timeLabel.text = timeFormatter.string(from: audioRecorder.elapsedTime)
    }
    
}
