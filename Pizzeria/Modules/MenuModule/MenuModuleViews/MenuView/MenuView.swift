//
//  MenuView.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 16.01.2024.
//

import UIKit

final class MenuView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .pizzeriaBackground
        tableView.estimatedRowHeight = 600
        tableView.separatorInset = .zero
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pizzeriaBackground
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    func reloadTableView() {
        tableView.reloadData()
    }

    private func setupSubviews() {
        addSubview(tableView)
        let headerRect = CGRect(x: 0, y: 0, width: frame.size.width, height: 132)
        tableView.tableHeaderView = BannersView(frame: headerRect)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
