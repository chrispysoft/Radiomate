//
//  AudioEngine.swift
//  Radiomate
//
//  Created by Chris on 22.09.23.
//

import Foundation
import AVFAudio

public final class AudioEngine {
    
    private let config: Config.Audio
    private var currentShow: Show?
    private var nextShow: Show?
    private let fallbackPlayer: AVAudioPlayer
    private var players: [AVAudioPlayer] = []
    
    
    init(config: Config.Audio) {
        self.config = config
        let fallback = Bundle.main.url(forResource: "Sine432", withExtension: "mp3")!
        fallbackPlayer = try! AVAudioPlayer(contentsOf: fallback)
    }
    
    public func update(_ show: Show?) {
        if let currentShow, currentShow.remainingTime <= config.fadeOutTime {
            NSLog("Fading out")
            players.last?.stop()
            self.currentShow = nil
        }
        if let show {
            if show.id != currentShow?.id {
                NSLog("Starting")
                do {
                    try start(show)
                }
                catch {
                    NSLog(error.localizedDescription)
                    fallbackPlayer.play()
                }
            }
        } else {
            fallbackPlayer.play()
        }
    }
    
    private func start(_ show: Show) throws {
        switch show.source {
        case .file:
            guard let path = show.path else { throw NSError() }
            let url = URL(filePath: path)
            let player = try AVAudioPlayer(contentsOf: url)
            let startOffset = abs(show.elapsedTime)
            player.currentTime = startOffset
            player.play()
            players.append(player)
            fallbackPlayer.stop()
        default:
            break
        }
        
        currentShow = show
    }
}


fileprivate extension Show {
    var elapsedTime: TimeInterval {
        Date.now.timeIntervalSince(dateFrom)
    }
    
    var remainingTime: TimeInterval {
        dateTo.timeIntervalSince(.now)
    }
}
