//
//  Models.swift
//  Radiomate
//
//  Created by Chris on 22.09.23.
//

import Foundation

public enum Source: Int {
    case analog = 1
    case stream = 2
    case file = 3
}

public struct Show {
    let id: Int
    let dateFrom: Date
    let dateTo: Date
    let source: Source
    let path: String?
}
