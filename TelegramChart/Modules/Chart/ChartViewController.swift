//
//  ChartViewController.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

class ChartViewController: UITableViewController {

    var presenter: ChartPresenter?
    var selections = [SelectionData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Statistics"
        presenter?.fetchData()
    }

    @IBAction func onSwitchModeTapped(_ sender: Any) {

    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "FOLLOWERS"
        default:
            return nil
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 + selections.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row > 0 {
            self.presenter?.didSelect(with: selections[indexPath.row - 1])
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "chartCellId", for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "columnCellId", for: indexPath)
                configure(cell: cell, with: selections[indexPath.row - 1])
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCellId", for: indexPath)
            return cell
        }
    }

    private func configure(cell: UITableViewCell, with selection: SelectionData) {
        cell.textLabel?.text = selection.title

        if let hexColor = Int(selection.color.dropFirst(), radix: 16) {
            let clr = UIColor(red: CGFloat((0xFF0000 & hexColor) >> 16) / 255.0,
                              green: CGFloat((0x00FF00 & hexColor) >> 8) / 255.0,
                              blue: CGFloat(0x0000FF & hexColor) / 255.0,
                              alpha: 1)
            cell.imageView?.image = clr.image(CGSize(width: 12, height: 12))
            cell.imageView?.layer.cornerRadius = 4
        } else {
            cell.imageView?.image = nil
        }

        cell.accessoryType = (selection.visible ? .checkmark : .none)
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension ChartViewController: ChartView {
    func configure(with selections: [SelectionData]) {
        self.selections = selections
        var cells = [IndexPath]()
        for index in 0..<selections.count {
            cells.append(IndexPath(row: 1 + index, section: 0))
        }
        tableView.reloadRows(at: cells, with: .automatic)
    }
}

