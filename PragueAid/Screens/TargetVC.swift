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
    
    var target: Target!
    var infoCells: [PAInfoCell] = []
    var openingHourCells: [PAInfoCell] = []
    var credentialCells: [PAInfoCell] = []
    
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
        configureVC()
        generateCells()
        configureTableView()
    }
    
    
    private func configureVC(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = target.name
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(PAInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: tableView.rowHeight)
        
        headerView = PATargetHeaderView(frame: frame)
        footerView = PAFooterView(frame: frame, message: "Last Updated: \(target.updatedAt.prefix(7))")
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        headerView?.navButton.addTarget(self, action: #selector(navButtonTapped), for: .touchUpInside)
        headerView?.callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        headerView?.favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func navButtonTapped(){print("navButtonTapped")}
    @objc private func callButtonTapped(){print("callButtonTapped")}
    @objc private func favButtonTapped(){print("favButtonTapped")}

    
    private func generateCells(){
        
        for property in target.getInfoProperties() {
            let cell = PAInfoCell(infoProperty: property)
            infoCells.append(cell)
        }
        
        
        if target.getOpeningProperties().isEmpty {
            let cell = PAInfoCell(content: "Unavailable", imageString: SFSymbol.unavailable.rawValue)
            cell.action = .web
            openingHourCells.append(cell)
        } else {
            for property in target.getOpeningProperties() {
                let cell = PAInfoCell(content: property, imageString: SFSymbol.chevron.rawValue)
                openingHourCells.append(cell)
            }
        }
        
        
        if target.targetTypeGroup == .pharmacies {
            let cell = PAInfoCell(content: target.institutionCode, imageString: SFSymbol.web.rawValue)
            credentialCells.append(cell)
        }
        
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
            return infoCells.count
        case 1:
            return openingHourCells.count
        case 2:
            return credentialCells.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PAInfoCell
        
        switch indexPath.section {
        case 0:
            return infoCells[indexPath.row]
        case 1:
            return openingHourCells[indexPath.row]
        case 2:
            return credentialCells[indexPath.row]
        default:
            break
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = TargetTableViewSections(rawValue: section)?.description
        return title
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: print(infoCells[indexPath.row].action)
        case 1: print(infoCells[indexPath.row].action)
        case 2: print(infoCells[indexPath.row].action)
        default: return
        }
    }
    
    
    
    
    
}
