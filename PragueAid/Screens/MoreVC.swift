//
//  OptionsVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit


class MoreVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let reuseIdentifier = "infoCell"
    
    var filterCells: [PAInfoCell] = []
    var miscCells: [PAInfoCell] = []
    var madeChanges = false
    
    
    override func viewDidLoad() {
        generateCells()
        configureTableView()
        loadFilterSettingsFromPersistance()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if madeChanges { saveFilterSettingsToPersistance() }
    }
    
    
//MARK: - UI
    
    private func generateCells(){
        for i in MoreTableViewFilterCells.allCases {
            let cell = PAInfoCell(content: i.description, imageString: i.image, toggle: true)
            cell.toggle!.addTarget(self, action: #selector(toggleSwitched), for: .allTouchEvents)
            filterCells.append(cell)
        }
        
        for i in MoreTableViewMiscCells.allCases {
            let cell = PAInfoCell(content: i.description, imageString: i.image, toggle: false)
            miscCells.append(cell)
        }
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
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
    
    
    private func setupFilterToggles(settings: FilterSettings){
        for (i, cell) in filterCells.enumerated() {
            cell.toggle!.setOn(settings.getArray()[i], animated: true)
        }
    }
    
    
    @objc func toggleSwitched(){
        madeChanges = true
    }
    

//MARK: - Persistance
    
    private func loadFilterSettingsFromPersistance(){
        PersistanceManager.shared.loadFilterSettingsFromPersistance(completed: {result in
            switch result {
            case .success(let loadedFilterSettings):
                self.setupFilterToggles(settings: loadedFilterSettings)
            case .failure(let error):
                self.presentErrorAlert(for: error)
            }
        })
    }
    
    
    private func saveFilterSettingsToPersistance(){
        let result = PersistanceManager.shared.saveFilterSettingsToPersistance(settings: getCurrentFilterSettings())
        if result != nil { self.presentErrorAlert(for: result!) }
    }
    
    
    private func getCurrentFilterSettings() -> FilterSettings {
        let settings = FilterSettings(pharmacies: filterCells[0].toggle!.isOn, medicalInstitutions: filterCells[1].toggle!.isOn)
        return settings
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
            return
        case 1:
            switch indexPath.row {
            case 0:
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            case 1:
                presentAlert(message: AlertMessages.cannotRate, title: AlertMessages.heart)
            case 2:
                present(UINavigationController(rootViewController: AboutVC()), animated: true)
            default:
                return
            }
        default:
            return
        }
    }
}


