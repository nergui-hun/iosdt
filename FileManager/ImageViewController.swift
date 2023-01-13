//
//  ImageViewController.swift
//  FileManager
//
//  Created by M M on 1/8/23.
//

import Foundation
import UIKit
import SnapKit
//Filename "ImageViewController.swift" used twice: '/Users/mm/WORK/FileManager/FileManager/ImageViewController.swift' and '/Users/mm/WORK/Fileman/Fileman/Controller/ImageViewController.swift'

class ImageViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()

    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.imageView = imageView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }

    private func setupView() {
        view.addSubview(imageView)
        imageView.pin(to: view)
    }
}
