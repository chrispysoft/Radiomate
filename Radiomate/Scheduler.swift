//
//  Radiomate.swift
//  Scheduler
//
//  Created by Chris on 22.09.23.
//

import Foundation

public final class Scheduler {
    
    private let config: Config
    private let db: Database
    private let api: API
    private let audioEngine: AudioEngine
    private var timer: Timer!
    
    init(config: Config) {
        self.config = config
        self.db = Database(config: config.db)
        self.api = API(config: config.api)
        self.audioEngine = AudioEngine(config: config.audio)
        timer = Timer.scheduledTimer(withTimeInterval: config.refreshInterval, repeats: true, block: refresh)
        try! api.start()
    }
    
    
    private func refresh(_ timer: Timer) {
        var show: Show?
        do {
            show = try db.currentShow()
            // NSLog(show.debugDescription)
        }
        catch {
            NSLog(error.localizedDescription)
        }
        
        audioEngine.update(show)
    }
    
}
