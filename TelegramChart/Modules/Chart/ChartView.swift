//
//  ChartView.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

struct SelectionData {
    let id: String
    let color: String
    let title: String
    var visible: Bool
}

protocol ChartView: class {
    func configure(with selections: [SelectionData])
}
