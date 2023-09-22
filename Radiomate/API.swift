//
//  API.swift
//  Radiomate
//
//  Created by Chris on 22.09.23.
//

import Foundation
import Swifter

public final class API {
    
    private let config: Config.API
    private let server = HttpServer()
    
    init(config: Config.API) {
        self.config = config
        server["/hello"] = hello
    }
    
    public func start() throws {
        try server.start(config.port, priority: .default)
    }
    
    
    private func hello(_ request: HttpRequest) -> HttpResponse {
        let hello = Hello()
        return .ok(.data(hello.jsonData, contentType: "application/json"))
    }
}

protocol JSONRepresentable: Codable {
    var jsonData: Data { get }
}

extension JSONRepresentable {
    var jsonData: Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
}

struct Hello: JSONRepresentable {
    let message = "hello"
}
