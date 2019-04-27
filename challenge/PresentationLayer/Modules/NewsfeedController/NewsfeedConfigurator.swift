//
//  NewsfeedConfigurator.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

class NewsfeedModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? NewsfeedViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: NewsfeedViewController) {
        let viewModel = NewsfeedModelView()
        viewModel.view = viewController
        viewModel.newsfeedService = NewsfeedService()
        viewModel.userService = UserService()
        viewController.viewModel = viewModel
    }
    
}
