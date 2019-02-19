//
//  AudioPostViewController.swift
//  LambdaTimeline
//
//  Created by Austin Cole on 2/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPostViewController: UIViewController {
    //MARK: Private Properties
    private let audioRecorder = Recorder()
    private let postController = PostController()
    
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
    }
    
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
    }
    
    @IBAction func createPost(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let audioFile = audioRecorder.currentFile else {
                presentInformationalAlertController(title: "Uh-oh", message: "Make sure that you make a recording before posting.")
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
    
}