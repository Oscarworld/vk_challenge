//
//  NewsfeedViewController.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

protocol NewsfeedViewControllerProtocol: AlertViewControllerProtocol {
    
    func setupInitialState()
    
    func configureWithItem(_ items: [Post], isExpanded: [Bool])
    
    func configureSearch(_ item: User)
    
    func stopRefreshing()
    
}

class NewsfeedViewController: UIViewController, NewsfeedViewControllerProtocol {
    
    var viewModel: NewsfeedModelViewProtocol!
    
    private var collectionView: NewsfeedCollectionView!
    
    private var backgroundLayer: CAGradientLayer!
    private var shadowLayer: CAShapeLayer!
    private var fillColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var statusBarView: UIView = {
        let view = UIView()
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = view.layer.contentsScale
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewIsReady()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutView()
        configureBackground()
    }
    
    func setupInitialState() {
        hideKeyboardWhenTappedAround()
        configureCollectionView()
        setupView()
        setupConstraints()
        configureRefreshControl()
    }
    
    func configureWithItem(_ items: [Post], isExpanded: [Bool]) {
        collectionView.isExpanded = isExpanded
        collectionView.posts = items
    }
    
    func configureSearch(_ item: User) {
        collectionView.avatarSrc = item.photo50
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.viewModel.getNewsfeed()
    }
    
    func stopRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    private func layoutView() {
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: statusBarView.bounds, cornerRadius: 0).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 1.0
            shadowLayer.shadowRadius = 8
            
            statusBarView.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    private func configureBackground() {
        if backgroundLayer != nil {
            backgroundLayer.removeFromSuperlayer()
        }
        
        let gradient = CAGradientLayer()
        backgroundLayer = gradient
        
        gradient.colors = [
            UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1).cgColor,
            UIColor(red: 0.92, green: 0.93, blue: 0.94, alpha: 1).cgColor
        ]
        
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0,
                                                                                b: 1,
                                                                                c: -1,
                                                                                d: 0,
                                                                                tx: 0.5,
                                                                                ty: 0))
        gradient.position = view.center
        
        gradient.frame = CGRect(x: 0.0,
                                y: 0.0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.height)
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func configureRefreshControl() {
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
    }
    
    private func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)
        
        collectionView = NewsfeedCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.searchDidChange = { [weak self] text in
            self?.viewModel.searchDidChange(text: text)
        }
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        view.addSubview(statusBarView)
        statusBarView.addSubview(blurEffectView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: statusBarView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: statusBarView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: statusBarView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
    }
}
