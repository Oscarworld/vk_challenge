//
//  ViewController+Alert.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

protocol AlertViewControllerProtocol {
    
    func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style)
    
}

extension AlertViewControllerProtocol where Self: UIViewController {
    
    func showAlert(title: String? = nil, message: String?, preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
