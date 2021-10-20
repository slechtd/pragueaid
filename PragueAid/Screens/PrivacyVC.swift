//
//  AboutVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 11.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let reuseIdentifier = "infoCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    
//MARK: - UI
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = Strings.privacyPolicy.rawValue.localized()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissTapped))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    
    @objc private func dismissTapped(){
        dismiss(animated: true)
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(PAInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - extensions

extension PrivacyVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PAInfoCell
        cell.textLabel?.text = Strings.privacyMessage.rawValue.localized()
        cell.textLabel?.numberOfLines = 10
        cell.selectionStyle = .none
        return cell
    }
}
