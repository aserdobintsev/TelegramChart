//
//  ChartsService.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

class ChartsService {
    private let dataFile = "chart_data.json"

    func getCharts(completionHandler: @escaping ([Chart]) -> Void) {
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let data = self?.loadData() else {
                fatalError()
            }
            let charts = self?.parse(with: data)
            completionHandler(charts ?? [])
        }
    }

    private func loadData() -> Data? {
        let url = Bundle.main.bundleURL.appendingPathComponent(dataFile)
        let data = try? Data(contentsOf: url)
        return data
    }

    private func parse(with data: Data) -> [Chart]? {
        let jsonRoot = try? JSONSerialization.jsonObject(with: data, options: [])
        var charts = [Chart]()
        if let jsonCharts = jsonRoot as? [[String: Any]] {
            for jsonChart in jsonCharts {
                if let chart = Chart.init(json: jsonChart) {
                    charts.append(chart)
                }
            }
        }
        return charts
    }
}
