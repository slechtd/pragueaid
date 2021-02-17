//
//  TargetVC.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit
import MapKit


class TargetVC: UIViewController {
    
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let reuseIdentifier = "infoCell"
    
    var target: Target!
    var infoCells: [PAInfoCell] = []
    var openingHourCells: [PAInfoCell] = []
    var credentialCells: [PAInfoCell] = []
    
    var headerView: PAButtonView?
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
    
    
//MARK: - UI
    
    private func configureVC(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = target.name
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }
    
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }
    
    
    private func generateCells(){
        for cellContent in target.getInfoContent() {
            if cellContent.textLine1 != "" {
                let cell = PAInfoCell(cellContent: cellContent)
                infoCells.append(cell)
            }
        }
        
        if target.getOpenings().isEmpty {
            let cell = PAInfoCell(content: otherStrings.unavailable.rawValue.localized(), imageString: SFSymbol.unavailable.rawValue)
            openingHourCells.append(cell)
        } else {
            for property in target.getOpenings() {
                let cell = PAInfoCell(content: property, imageString: SFSymbol.chevron.rawValue)
                openingHourCells.append(cell)
            }
        }
        
        if target.targetTypeGroup == .pharmacies {
            let cell = PAInfoCell(content: target.institutionCode, imageString: SFSymbol.web.rawValue)
            credentialCells.append(cell)
        }
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(PAInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: tableView.rowHeight)
        
        headerView = PAButtonView(frame: frame, style: .target)
        headerView?.style = .target
        footerView = PAFooterView(frame: frame, message: "\(otherStrings.lastUpdated.rawValue.localized()) \(target.updatedAt.prefix(7))")
        
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
        
        headerView?.leftButton!.addTarget(self, action: #selector(navButtonTapped), for: .touchUpInside)
        headerView?.rightButton!.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func navButtonTapped(){launchMaps()}
    @objc private func callButtonTapped(){handlePhoneAction()}

    
    private func launchMaps(){
        target.mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    
//MARK: - Web/Tel/Mail Handling
    
    //opens URL on a physical device only.
    func handleEmailAction(){
        if self.target.email2 == "" {
            guard let url = URL(string: "mailto://\(self.target.email1)") else {return}
            UIApplication.shared.open(url)
            print(url)
        } else {
            self.present(generateEmailActionSheet(), animated: true)
        }
    }
 
    
    //opens URL on a physical device only.
    func handlePhoneAction(){
        if self.target.telephone2 == "" {
            guard let url = URL(string: "tel://+420\(self.target.telephone1.removeAllSpaces())") else {return}
            UIApplication.shared.open(url)
        } else {
            self.present(generateTelephoneActionSheet(), animated: true)
        }
    }
    
    
    func handleWebAction(){
        if self.target.web2 == "" {
            guard let url = URL(string: "http://www.\(self.target.web1)") else {return}
            self.presentSafariVC(with: url)
        } else {
            self.present(generateWebActionSheet(), animated: true)
        }
    }
    
    
    private func generateEmailActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: otherStrings.cancel.rawValue.localized(), style: .cancel))
        if target.email1 != "" {actionSheet.addAction(UIAlertAction(title: target.email1, style: .default, handler: { action in
            guard let url = URL(string: "mailto://\(self.target.email1)") else {return}
            UIApplication.shared.open(url)
        }))}
        if target.email2 != "" {actionSheet.addAction(UIAlertAction(title: target.email2, style: .default, handler: { action in
            guard let url = URL(string: "mailto://\(self.target.email1)") else {return}
            UIApplication.shared.open(url)
        }))}
        return actionSheet
    }
    
    
    private func generateTelephoneActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: otherStrings.cancel.rawValue.localized(), style: .cancel))
        if target.telephone1 != "" {actionSheet.addAction(UIAlertAction(title: target.telephone1, style: .default, handler: { action in
            guard let url = URL(string: "tel://+420\(self.target.telephone1.removeAllSpaces())") else {return}
            UIApplication.shared.open(url)
        }))}
        if target.telephone2 != "" {actionSheet.addAction(UIAlertAction(title: target.telephone2, style: .default, handler: { action in
            guard let url = URL(string: "tel://+420\(self.target.telephone2.removeAllSpaces())") else {return}
            UIApplication.shared.open(url)
        }))}
        return actionSheet
    }
    
    
    private func generateWebActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: otherStrings.cancel.rawValue.localized(), style: .cancel))
        if target.web1 != "" {actionSheet.addAction(UIAlertAction(title: target.web1, style: .default, handler: { action in
            guard let url = URL(string: "http://www.\(self.target.web1)") else {return}
            self.presentSafariVC(with: url)
        }))}
        if target.web2 != "" {actionSheet.addAction(UIAlertAction(title: target.web2, style: .default, handler: { action in
            guard let url = URL(string: "http://www.\(self.target.web2)") else {return}
            self.presentSafariVC(with: url)
        }))}
        return actionSheet
    }
}


//MARK: - extensions

extension TargetVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if target.targetTypeGroup == .pharmacies {
            return TargetTableViewSections.allCases.count
        } else {
            return TargetTableViewSections.allCases.count - 1
        }
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
        case 0:
            handleInfoCellsActions(indexPath: indexPath)
        case 1:
            return
        case 2:
            let url = URL(string: "http://www.sukl.cz/lekarna/\(self.target.institutionCode)")
            presentSafariVC(with: url!)
        default:
            return
        }
    }
    
    
    func handleInfoCellsActions(indexPath: IndexPath) {
        switch infoCells[indexPath.row].action {
        case .address:
            launchMaps()
        case .email:
            handleEmailAction()
        case .phone:
            handlePhoneAction()
        case .web:
            handleWebAction()
        default:
            return
        }
    }
}

