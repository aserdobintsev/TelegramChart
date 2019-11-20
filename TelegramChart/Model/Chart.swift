//
//  Chart.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

struct Chart {
    let xaxis: Line
    let lines: [Line]
}

struct Line {
    let id: String
    let name: String
    let color: String
    let values: [Int]
}

enum LineType: String {
    case line, x
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

        var lines = [Line]()
        var x: Line?
        for column in columns {
            var arr = [Any](column)
            guard let id = arr.remove(at: 0) as? String,
                let values = arr as? [Int] else {
                    continue
            }
            switch types[id] {
            case LineType.x.rawValue:
                x = Line(id: id, name: "", color: "", values: values)
            case LineType.line.rawValue:
                lines.append(Line(id: id,
                                  name: names[id] ?? "",
                                  color: colors[id] ?? "",
                                  values: values))
            default:
                continue
            }
        }
        guard let axis = x else {
            return nil
        }
        self.xaxis = axis
        self.lines = lines
    }
}
