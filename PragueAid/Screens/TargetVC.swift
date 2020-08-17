//
//  TargetVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

class TargetVC: UIViewController {

    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let reuseIdentifier = "infoCell"
    
    var target: Target?
    var headerView: PATargetHeaderView?
    var footerView: PAFooterView?
    
    
    init (target: Target) {
        super.init(nibName: nil, bundle: nil)
        self.target = target
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNC()
        configureTableView()
    }
    
    
    private func configureNC(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = target?.name
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(PAInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let headerFrame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        let footerFrame = CGRect(x: 0, y: 88, width: view.frame.width, height: 50)
        headerView = PATargetHeaderView(frame: headerFrame)
        footerView = PAFooterView(frame: footerFrame)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        
        headerView?.backgroundColor = .systemPink
        footerView?.backgroundColor = .systemTeal
        
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

extension TargetVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TargetTableViewSections.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return target?.openingHours == nil || (target?.openingHours?.isEmpty)! ? 1 : 7
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PAInfoCell
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .systemBlue
        case 1:
            cell.backgroundColor = .systemRed
        case 2:
            cell.backgroundColor = .systemYellow
        default:
            cell.backgroundColor = .systemIndigo
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = TargetTableViewSections(rawValue: section)?.description
        return title
    }
    
    
    
    
    
}
