//
//  AudioPlayer.swift
//  InternZee
//
//  Created by Milind Trivedi on 05/09/22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch let err {
            print(err.localizedDescription)
        }
    }
}
