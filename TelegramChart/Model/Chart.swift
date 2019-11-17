//
//  Chart.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

struct ChartTest: Decodable {
    //let columns: [String: [Int]]
    let types: [String: String] // +
    let names: [String: String] // +
    let colors: [String: String] // +
}

struct Chart {
    let columns: [String: [Int]]
    let types: [String: String] // +
    let names: [String: String] // +
    let colors: [String: String] // +
}

extension Chart {
    init?(json: [String: Any]) {
        guard let columns = json["columns"] as? [[Any]],
            let types = json["types"] as? [String: String],
            let names = json["names"] as? [String: String],
            let colors = json["colors"] as? [String: String]
        else {
            return nil
        }
        self.types = types
        self.names = names
        self.colors = colors

        var namedColumns = [String: [Int]]()

        for column in columns {
            var arr = [Any](column)
            guard let name = arr.remove(at: 0) as? String,
                let values = arr as? [Int] else {
                    continue
            }
            namedColumns[name] = values
        }
        self.columns = namedColumns
    }
}
