//
//  ChartViewController.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit



class ChartViewController: UIViewController {

    var presenter: ChartPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Statistics"
        presenter?.fetchData()
    }
}

extension ChartViewController: ChartView {

}
