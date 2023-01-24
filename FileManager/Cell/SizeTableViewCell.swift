//
//  SizeTableViewCell.swift
//  FileManager
//
//  Created by M M on 1/24/23.
//

import Foundation
import UIKit
import SnapKit

final class SizeTableViewCell: UITableViewCell {

    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Show size"
        return label
    } ()

    private let sizeSwitch: UISwitch = {
        let sizeSwitch = UISwitch()
        let value = UserDefaults.standard.bool(forKey: "Show size") == true ||
        UserDefaults.standard.object(forKey: "Show size") == nil
        sizeSwitch.setOn(value, animated: false)
        sizeSwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)
        return sizeSwitch
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
            UserDefaults.standard.set(true, forKey: "Show size")
        } else {
            UserDefaults.standard.set(false, forKey: "Show size")
        }
    }

    private func setupView() {
        [sizeLabel, sizeSwitch].forEach {contentView.addSubview($0)}
        sizeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.left.equalToSuperview().offset(10)
        }

        sizeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(sizeLabel)
            make.rightMargin.equalToSuperview().offset(-10)
        }
    }
}
