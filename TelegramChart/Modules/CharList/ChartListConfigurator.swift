//
//  ChartListConfigurator.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

final class ChartListConfigurator {
    func configure() -> UIViewController {
        guard let view = UIStoryboard(name: String(describing: ChartListViewController.self),
                                              bundle: Bundle.main).instantiateInitialViewController() as? ChartListViewController
                    else {
                        fatalError("""
        Can't load ChartListViewController from storyboard,
        check that controller is initial view controller
        """)
        }


        let service = ChartsService()
        let presenter = ChartListPresenterImpl(view: view, service: service)
        view.presenter = presenter
        return view
    }
}
