//
//  StartModelView.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol StartModelViewProtocol {
    
    func viewIsReady()
    
    func didTappedLogInButton()
    
}

class StartModelView: NSObject, StartModelViewProtocol {
    
    public weak var view: (UIViewController & StartViewControllerProtocol)!
    
    private let appId = "6746773"
    
    func viewIsReady() {
        self.view.setupInitialState()
        self.configureVKSdk()
        self.wakeUpSession()
    }
    
    func didTappedLogInButton() {
        VKSdk.authorize([VK_PER_WALL, VK_PER_FRIENDS])
    }
    
    private func configureVKSdk() {
        let sdkInstance = VKSdk.initialize(withAppId: appId)
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
    }
    
    private func wakeUpSession() {
        VKSdk.wakeUpSession([VK_API_LONG]) { [weak self] state, error in
            if state == .authorized {
                self?.startWorking()
            } else if let error = error {
                self?.view.showAlert(title: nil, message: error.localizedDescription)
            }
        }
    }
    
    private func startWorking() {
        let newsfeedViewController = NewsfeedViewController()
        let newsfeedConfigurator = NewsfeedModuleConfigurator()
        newsfeedConfigurator.configureModuleForViewInput(viewInput: newsfeedViewController)
        
        AppDelegate.shared.window?.rootViewController = newsfeedViewController
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
}

extension StartModelView: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result.token {
            ApiService.shared.accessToken = token.accessToken
            self.startWorking()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        self.view.showAlert(title: nil, message: "Access denied")
    }
}

extension StartModelView: VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.view.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        guard let vc = VKCaptchaViewController.captchaControllerWithError(captchaError) else {
            return
        }
        
        self.view.present(vc, animated: true, completion: nil)
    }
}
