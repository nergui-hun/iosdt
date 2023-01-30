//
//  ViewController.swift
//  Fileman
//
//  Created by M M on 11/3/22.
//

import UIKit


final class ViewController: UIViewController {


    // MARK: - Values

    var delegate: ViewControllerDelegate?
    let url: URL
    var dataSource: [URL] = []
    private var files: [URL]?

    // MARK: - View Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "folderCell")

        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    } ()

    private lazy var newFolderButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "folder.badge.plus")
        button.tintColor = .systemBlue
        button.target = self
        button.action = #selector(addFolder)
        return button
    } ()

    private lazy var newPictureButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.tintColor = .systemBlue
        button.target = self
        button.action = #selector(addPicture)
        return button
    } ()

    // MARK: - init
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupView()

        self.files = FileManagerService.shared.contentsOfDirectory(folderURL: self.url)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh()
    }

    private func setupNavBar() {
        title = url.lastPathComponent
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setRightBarButtonItems([newPictureButton, newFolderButton], animated: true)
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.pin(to: self.view)
    }

    @objc func addFolder() {
        let alertController = UIAlertController(title: "Введите название папки", message: "", preferredStyle: .alert)
        let addAlertAction = UIAlertAction(title: "Добавить", style: .default) { (action) -> Void in
            if let nameTextField = alertController.textFields?.first, let folderName = nameTextField.text {
                FileManagerService.shared.createDirectory(with: folderName, folderURL: self.url)
                self.refresh()
            }
        }

        let cancelAlertAction = UIAlertAction(title: "Отменить", style: .cancel)

        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(addAlertAction)
        alertController.addAction(cancelAlertAction)

        self.present(alertController, animated: true, completion: nil)
    }

    @objc func addPicture() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        DispatchQueue.main.async {
            self.present(imagePickerController, animated: true, completion: nil)
        }
        self.refresh()
    }

    func refresh() {
        self.files = FileManagerService.shared.contentsOfDirectory(folderURL: self.url)

        if UserDefaults.standard.bool(forKey: "A-Z") == true ||
            UserDefaults.standard.object(forKey: "A-Z") == nil {
            self.files?.sort(by: { $0.lastPathComponent < $1.lastPathComponent })
        } else {
            self.files?.sort(by: { $1.lastPathComponent < $0.lastPathComponent })
        }
        self.tableView.reloadData()
    }

    // MARK: - Observers

}

// MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as?
                MainTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            return cell
        }

        let folderUrl = (files?[indexPath.row])!
        let data = FileManager.default.contents(atPath: folderUrl.path())
        cell.folderLabel.text = folderUrl.lastPathComponent

        if !folderUrl.isDirectory {
            cell.accessoryType = .none
            if UserDefaults.standard.bool(forKey: "Show size") == true ||
                UserDefaults.standard.object(forKey: "Show size") == nil {
                let imageSize = (Double(data?.count ?? 0) / 1024 / 1024)
                cell.sizeLabel.text = String(format: "%.2f Mb", imageSize)
                cell.sizeLabel.isHidden = false
            } else {
                cell.sizeLabel.isHidden = true
            }
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.sizeLabel.isHidden = true
        }

        cell.selectionStyle = .none
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderUrl = (files?[indexPath.row])!
        if folderUrl.isDirectory {
            self.delegate?.openFolder(url: url, title: folderUrl.lastPathComponent)
        } else {
            let data = FileManager.default.contents(atPath: folderUrl.path())
            let image = UIImage(data: data ?? Data()) ?? UIImage(systemName: "zurg.fill")
            self.delegate?.redirectToImageVC(image: image!)
        }
        //tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        FileManagerService.shared.removeContent(url: dataSource[indexPath.row])
        refresh()
    }
}

extension ViewController {
    func fetchData() -> [URL] {
        var files = [URL]()
        let data: [URL] = FileManagerService.shared.contentsOfDirectory(folderURL: self.url)!
        print(url.lastPathComponent)

        for file in data {
            files.append(file)
        }
        //why cant we just do this:
        //return FileManagerService.shared.contentsOfDirectory(folderURL: self.url)!
        return files
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //add it to your directory
        if let image = info[.originalImage] as? UIImage {
            guard let data = image.jpegData(compressionQuality: 1.0) else  {
                print("Error getting data")
                return
            }
            guard let imageURL = info[.imageURL] as? URL else { return }
            FileManagerService.shared.createFile(with: data, folderURL: url, filename: imageURL.lastPathComponent)
        }
        self.refresh()
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
