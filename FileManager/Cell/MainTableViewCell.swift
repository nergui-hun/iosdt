//
//  MainTableViewCell.swift
//  Filemanager
//
//  Created by M M on 11/9/22.
//

import Foundation
import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {

    // MARK: - Values


    // MARK: - View Elements

    var folderLabel: UILabel = {
        let label = UILabel()
        label.text = "Folder"
        label.textColor = .black
        return label
    } ()

    var sizeLabel: UILabel = {
        let label = UILabel()
        return label
    } ()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    } ()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    } ()

    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func addSubviews() {
        addSubview(stackView)
        stackView.addSubview(iconImageView)
        stackView.addSubview(folderLabel)
        stackView.addSubview(sizeLabel)
    }

    private func setConstraints() {
        stackView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        folderLabel.snp.makeConstraints { make in
            make.center.height.equalToSuperview()
            make.width.equalToSuperview().inset(70)
        }

        iconImageView.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
            make.height.width.equalTo(40)
        }

        sizeLabel.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(65)
        }
    }

    func set(folderName: String) {
        folderLabel.text = folderName
    }

    // MARK: - Observers

    // MARK: - Extensions
}
