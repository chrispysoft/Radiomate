//
//  Database.swift
//  Radiomate
//
//  Created by Chris on 22.09.23.
//

import Foundation
import PostgresClientKit

public final class Database {
    
    private let pgConfig: PostgresClientKit.ConnectionConfiguration
    
    init(config: Config.DB) {
        var pgConfig = PostgresClientKit.ConnectionConfiguration()
        pgConfig.host = config.host
        pgConfig.user = config.user
        pgConfig.database = config.database
        pgConfig.credential = .trust
        pgConfig.ssl = false
        self.pgConfig = pgConfig
    }
    
    
    public func currentShow() throws -> Show? {
        let connection = try PostgresClientKit.Connection(configuration: pgConfig)
        defer { connection.close() }
        
        let now = PostgresTimestamp(date: Date(), in: .gmt)
        let query = "SELECT * FROM shows WHERE date_from <= $1 AND date_to >= $1;"
        let statement = try connection.prepareStatement(text: query)
        defer { statement.close() }
        
        let cursor = try statement.execute(parameterValues: [now])
        defer { cursor.close() }
        
        guard let row = cursor.next() else { return nil }
        
        let columns = try row.get().columns
        let id = try columns[0].int()
        let date_from = try columns[1].timestampWithTimeZone().date
        let date_to = try columns[2].timestampWithTimeZone().date
        let source_id = try columns[3].int()
        let source_path = try columns[4].optionalString()
        
        guard let source = Source(rawValue: source_id) else { throw Error.invalidSourceID(source_id) }
        let show = Show(id: id, dateFrom: date_from, dateTo: date_to, source: source, path: source_path)
        return show
    }
}


public extension Database {
    enum Error: Swift.Error {
        case invalidSourceID(Int)
    }
}
