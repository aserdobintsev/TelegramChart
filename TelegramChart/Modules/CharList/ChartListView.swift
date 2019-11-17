//
//  ChartListView.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

protocol ChartListView: class {
    func showDetail(view: UIViewController)
    func reloadData()
    func startRefresh()
    func stopRefresh()
}
