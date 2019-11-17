//
//  ChartPresenter.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation


protocol ChartPresenter: class {
    init(view: ChartView, model: Chart)
    func fetchData()
}

class ChartPresenterImpl: ChartPresenter {

    private unowned let view: ChartView?
    private let model: Chart

    required init(view: ChartView, model: Chart) {
        self.view = view
        self.model = model
    }

    func fetchData() {

    }
}
