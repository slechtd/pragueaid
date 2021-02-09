//
//  OptionsVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

class MoreVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let reuseIdentifier = "infoCell"
    
    var filterCells: [PAInfoCell] = []
    var miscCells: [PAInfoCell] = []
    
    var footerView: PAFooterView?
    
    
    
    override func viewDidLoad() {
        generateCells()
        configureTableView()
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(PAInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: tableView.rowHeight)
        
        footerView = PAFooterView(frame: frame, message: "test")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    #warning("takhle upravit i bunky na target VC")
    private func generateCells(){
        
        for i in MoreTableViewFilterCells.allCases {
            let cell = PAInfoCell(content: i.description, imageString: i.image, toggle: true)
            filterCells.append(cell)
        }
        
        for i in MoreTableViewMiscCells.allCases {
            let cell = PAInfoCell(content: i.description, imageString: i.image, toggle: false)
            miscCells.append(cell)
        }
    }
    
    
    
    
    

}

//MARK: - extensions


extension MoreVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MoreTableViewSections.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return filterCells.count
        case 1:
            return miscCells.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PAInfoCell
        switch indexPath.section {
        case 0:
            return filterCells[indexPath.row]
        case 1:
            return miscCells[indexPath.row]
        default:
            break
        }
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = MoreTableViewSections(rawValue: section)?.description
        return title
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return //temp
        case 1:
            return //temp
        default:
            return
        }
    }

    
}
