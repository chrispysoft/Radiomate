//
//  Config.swift
//  Radiomate
//
//  Created by Chris on 22.09.23.
//

import Foundation

public struct Config {
    
    let refreshInterval = 3.0
    let api = API()
    let db = DB()
    let audio = Audio()
    
    struct API {
        let port: UInt16 = 6669
    }
    
    struct DB {
        let host = "localhost"
        let database = "radiomate"
        let user = "chris"
        let password = ""
        let useSSL = false
    }
    
    struct Audio {
        let fadeInTime = 3.0
        let fadeOutTime = 3.0
        let deviceName = "8M"
        let outputsMap = [8,9]
    }
    
    
    
}
