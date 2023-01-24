//
//  SettingsViewController.swift
//  FileManager
//
//  Created by M M on 1/18/23.
//

import Foundation
import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    // MARK: - Values
    var delegate: SettingsViewControllerDelegate?

    // MARK: - View Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: "aliceblue")
        tableView.isScrollEnabled = false
        tableView.register(SortTableViewCell.self, forCellReuseIdentifier: "sortCell")
        tableView.register(SizeTableViewCell.self, forCellReuseIdentifier: "sizeCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    } ()

    // MARK: - init

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "aliceblue")
        setupView()
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
    }

    // MARK: - Observers

    // MARK: - Extensions


}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //()
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell: SortTableViewCell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath) as! SortTableViewCell
            cell.selectionStyle = .none
            return cell
        case (0, 1):
            let cell: SizeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "sizeCell", for: indexPath) as! SizeTableViewCell
            cell.selectionStyle = .none
            return cell
        case (1, 0):
            let cell = UITableViewCell(frame: .zero)
            var content = cell.defaultContentConfiguration()
            content.text = "Change password"
            content.textProperties.color = .systemBlue
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            UserDefaults.standard.set(true, forKey: "changePass")
            KeychainService().removeData(key: "password")
            self.delegate?.navigateToLoginVC()
        }
    }


}
