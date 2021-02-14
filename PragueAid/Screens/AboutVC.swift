//
//  AboutVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 11.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let reuseIdentifier = "infoCell"
    
    var footerView: PAButtonView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = otherStrings.aboutThisApp.rawValue.localized()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissTapped))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    
    @objc private func dismissTapped(){
        dismiss(animated: true)
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(PAInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 50)
        
        footerView = PAButtonView(frame: frame, style: .about)
        
        tableView.tableFooterView = footerView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        footerView?.leftButton!.addTarget(self, action: #selector(gitHubButtonTapped), for: .touchUpInside)
        footerView?.rightButton!.addTarget(self, action: #selector(linkedInButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc private func gitHubButtonTapped(){
        guard let url = URL(string: "https://github.com/slechtd/pragueaid") else {return}
        self.presentSafariVC(with: url)
    }
    
    
    @objc private func linkedInButtonTapped(){
        guard let url = URL(string: "https://www.linkedin.com/in/daniel-slechta/") else {return}
        self.presentSafariVC(with: url)
    }
    
}

//MARK: - extensions

extension AboutVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PAInfoCell
        cell.textLabel?.text = otherStrings.about.rawValue.localized()
        //cell.textLabel?.lineBreakMode = .byTruncatingMiddle
        cell.textLabel?.numberOfLines = 10
        return cell
    }
}
