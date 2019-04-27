//
//  StartConfigurator.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

class StartModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? StartViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: StartViewController) {
        let viewModel = StartModelView()
        viewModel.view = viewController
        viewController.viewModel = viewModel
    }
}
