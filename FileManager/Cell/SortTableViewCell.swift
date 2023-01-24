//
//  SortTableViewCell.swift
//  FileManager
//
//  Created by M M on 1/24/23.
//

import Foundation
import UIKit
import SnapKit

final class SortTableViewCell: UITableViewCell {

    private var sortLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort: ascending"
        label.numberOfLines = 0
        return label
    } ()

    private let sortSwitch: UISwitch = {
        let sortSwitch = UISwitch()
        let value = UserDefaults.standard.bool(forKey: "A-Z") == true ||
        UserDefaults.standard.object(forKey: "A-Z") == nil
        sortSwitch.setOn(value, animated: false)
        sortSwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        return sortSwitch
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    @objc func switchStateDidChange(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "A-Z")
        } else {
            UserDefaults.standard.set(false, forKey: "A-Z")
        }
    }

    private func setupView() {
        [sortLabel, sortSwitch].forEach {contentView.addSubview($0)}
        sortLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.left.equalToSuperview().offset(10)
        }

        sortSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(sortLabel)
            make.rightMargin.equalToSuperview().offset(-10)
        }
    }
}
