//
//  ViewController.swift
//  challenge
//
//  Created by Oscar on 11/9/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

protocol StartViewControllerProtocol: AlertViewControllerProtocol {
    
    func setupInitialState()
    
}

class StartViewController: UIViewController, StartViewControllerProtocol {
    
    var viewModel: StartModelViewProtocol!
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vk-logo")
        return imageView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 71.0/255.0, green: 114.0/255.0, blue: 164.0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(logInButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewIsReady()
    }
    
    func setupInitialState() {
        self.view.backgroundColor = UIColor(red: 82.0/255.0, green: 129.0/255.0, blue: 185.0/255.0, alpha: 1.0)
        self.view.addSubview(logoImageView)
        self.view.addSubview(logInButton)
        
        self.setupConstraints()
    }
    
    @objc private func logInButtonDidTapped() {
        self.viewModel.didTappedLogInButton()
    }
    
    private func setupConstraints() {
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160).isActive = true
        self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.logoImageView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        self.logoImageView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        self.logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.logInButton.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 50).isActive = true
        self.logInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.logInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
