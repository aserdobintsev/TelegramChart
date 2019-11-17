//
//  ChartListPresenter.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol ChartListPresenter: class {
    init(view: ChartListView, service: ChartsService)
    var chartsCount: Int { get }
    func fetchData()
    func selected(with index: Int)
}

class ChartListPresenterImpl: ChartListPresenter {

    private let view: ChartListView
    private let service: ChartsService
    private var charts = [Chart]()
    required init(view: ChartListView, service: ChartsService) {
        self.view = view
        self.service = service
    }

    var chartsCount: Int { get { charts.count } }

    func fetchData() {
        view.startRefresh()

        service.getCharts() { [weak self] charts in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.view.stopRefresh()
                self.charts.removeAll()
                self.charts.append(contentsOf: charts)
                self.view.reloadData()
            }

        }
    }

    func selected(with index: Int) {
//        let configurator = ChartConfigurator()
//        let view = configurator.confugure(with: charts[index])
//        self.view.showDetail(view)
    }
}
