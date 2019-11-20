//
//  ChartPresenter.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

protocol ChartPresenter: class {
    init(view: ChartView, model: Chart)
    var columnsCount: Int { get }
    func fetchData()
    func switchAppearence()
    func didSelect(with: SelectionData)
}

class ChartPresenterImpl: ChartPresenter {

    private unowned let view: ChartView?
    private let model: Chart

    private var selections: [SelectionData]

    required init(view: ChartView, model: Chart) {
        self.view = view
        self.model = model
        var selections = [SelectionData]()
        for line in model.lines {
            let data = SelectionData(id: line.id,
                                     color: line.color,
                                     title: line.name,
                                     visible: true)
            selections.append(data)
        }
        self.selections = selections
    }

    var columnsCount: Int { model.lines.count }

    func fetchData() {
        self.view?.configure(with: selections)
    }

    func didSelect(with data: SelectionData) {
        if let index = selections.firstIndex(where: { $0.id == data.id }) {
            var toggled = data
            toggled.visible.toggle()
            selections[index] = toggled
        }
        self.view?.configure(with: selections)
    }

    func switchAppearence() {

    }
}
