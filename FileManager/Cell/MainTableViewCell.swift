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

    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
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
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addSubview(folderLabel)z
    }

    private func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(50)
        }

        stackView.snp.makeConstraints{ make in
            make.top.height.equalToSuperview()
            make.right.left.equalToSuperview().inset(16)
        }

        folderLabel.snp.makeConstraints { make in
            make.center.height.width.equalToSuperview()
        }
    }

    func set(folderName: String) {
        folderLabel.text = folderName
    }

    // MARK: - Observers

    // MARK: - Extensions
}
