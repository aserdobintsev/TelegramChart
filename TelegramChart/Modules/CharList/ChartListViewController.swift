//
//  ChartListViewController.swift
//  TelegramChart
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

class ChartListViewController: UITableViewController {

    var presenter: ChartListPresenter?
    private let reuseIdentifier = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Charts"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        configurePullToRefresh()
        self.presenter?.fetchData()
    }

    private func configurePullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc
    private func fetchData() {
        presenter?.fetchData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.selected(with: indexPath.row)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.presenter?.chartsCount ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }

}

extension ChartListViewController: ChartListView {
    func showDetail(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }

    func reloadData() {
        self.tableView.reloadData()
    }

    func startRefresh() {
        tableView.refreshControl?.beginRefreshing()
    }

    func stopRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
}
