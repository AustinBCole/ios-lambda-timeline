//
//  Comment.swift
//  LambdaTimeline
//
//  Created by Spencer Curtis on 10/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import FirebaseAuth

enum CommentType {
    case text
    case audio
}

class Comment: FirebaseConvertible, Equatable {
    
    static private let videoDataKey = "videoData"
    static private let audioDataKey = "audioData"
    static private let textKey = "text"
    static private let author = "author"
    static private let timestampKey = "timestamp"
    
    let videoData: Data?
    let audioData: Data?
    let text: String?
    let author: Author
    let timestamp: Date
    
    init(text: String?, audioData: Data?, videoData: Data?, author: Author, timestamp: Date = Date()) {
        self.text = text
        self.author = author
        self.timestamp = timestamp
        self.audioData = audioData
        self.videoData = videoData
    }
    
    init?(dictionary: [String : Any]) {
        guard let authorDictionary = dictionary[Comment.author] as? [String: Any],
            let author = Author(dictionary: authorDictionary),
            let timestampTimeInterval = dictionary[Comment.timestampKey] as? TimeInterval else { return nil }
        
        if let text = dictionary[Comment.textKey] as? String {
            self.text = text
        } else {
            self.text = nil
        }
        if let audioData = dictionary[Comment.audioDataKey] as? String {
            self.audioData = Data(base64Encoded: audioData)
        } else {
            self.audioData = nil
        }
        if let videoData = dictionary[Comment.videoDataKey] as? String {
            self.videoData = Data(base64Encoded: videoData)
        } else {
            self.videoData = nil
        }
        self.author = author
        self.timestamp = Date(timeIntervalSince1970: timestampTimeInterval)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [Comment.textKey: text,
                Comment.videoDataKey: videoData?.base64EncodedString(),
                Comment.audioDataKey: audioData?.base64EncodedString(),
                Comment.author: author.dictionaryRepresentation,
                Comment.timestampKey: timestamp.timeIntervalSince1970]
    }
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.author == rhs.author &&
            lhs.timestamp == rhs.timestamp
    }
}
