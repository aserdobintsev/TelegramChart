//
//  ChartConfigurator.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

final class ChartConfigurator {
    func configure(with chart: Chart) -> UIViewController {
        guard let view = UIStoryboard(name: String(describing: ChartViewController.self),
                                              bundle: Bundle.main).instantiateInitialViewController() as? ChartViewController
                    else {
                        fatalError("""
        Can't load ChartListViewController from storyboard,
        check that controller is initial view controller
        """)
        }

        let presenter = ChartPresenterImpl(view: view, model: chart)
        view.presenter = presenter
        return view
    }
}
