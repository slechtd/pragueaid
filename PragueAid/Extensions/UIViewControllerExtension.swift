//
//  UIViewControllerExtension.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 17/08/2020.
//  Copyright © 2020 Daniel Šlechta. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(for error: PAError, title: AlertMessages = AlertMessages.oops){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title.rawValue, message: error.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    
    func presentAlert(message: AlertMessages, title: AlertMessages = AlertMessages.oops){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
}

