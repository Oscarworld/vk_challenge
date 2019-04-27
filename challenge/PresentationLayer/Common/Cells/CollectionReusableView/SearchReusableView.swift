//
//  SearchReusableView.swift
//  challenge
//
//  Created by Oscar on 11/12/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

class SearchReusableView: UICollectionReusableView {
 
    public var searchDidChange: (String) -> () = { _ in }
    
    private lazy var searchTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 0, green: 0.11, blue: 0.24, alpha: 0.06)
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.layer.shouldRasterize = true
        textView.layer.rasterizationScale = textView.layer.contentsScale
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 36, bottom: 8, right: 8)
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = UIColor(red: 0.51, green: 0.55, blue: 0.60, alpha: 1.0)
        textView.text = "Search"
        textView.delegate = self
        return textView
    }()
    
    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_search")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var userAvatarButton: UIButton = {
        let button = UIButton()
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        button.imageView?.layer.cornerRadius = 18
        button.imageView?.clipsToBounds = true
//        button.imageView?.layer.shouldRasterize = true
//        button.imageView?.layer.rasterizationScale = button.imageView?.layer.contentsScale
        return button
    }()
    
    private lazy var searchTextViewTrailingConstraint = self.searchTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(search: String?, src: String?) {
        searchTextView.text = search ?? "Search"
        searchTextView.textColor = search == nil ? UIColor(red: 0.51, green: 0.55, blue: 0.60, alpha: 1.0) : .black
        if let src = src {
            userAvatarButton.download(from: src)
        }
    }
    
    private func setupView() {
        addSubview(searchTextView)
        searchTextView.addSubview(searchIcon)
        
        addSubview(userAvatarButton)
    }
    
    private func setupConstraint() {
        searchTextView.translatesAutoresizingMaskIntoConstraints = false
        searchTextView.topAnchor.constraint(equalTo: topAnchor, constant: 36).isActive = true
        searchTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        searchTextView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        searchTextViewTrailingConstraint.isActive = true
        
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.leadingAnchor.constraint(equalTo: searchTextView.leadingAnchor, constant: 12).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: searchTextView.centerYAnchor).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        userAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        userAvatarButton.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        userAvatarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        userAvatarButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        userAvatarButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func showAvatar(_ show: Bool) {
        if show {
            searchTextViewTrailingConstraint.constant = -60
            userAvatarButton.isHidden = false
        } else {
            searchTextViewTrailingConstraint.constant = -12
            userAvatarButton.isHidden = true
        }
    }
    
}

extension SearchReusableView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 0.51, green: 0.55, blue: 0.60, alpha: 1.0) {
            textView.text = nil
            textView.textColor = .black
            showAvatar(false)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Search"
            textView.textColor = UIColor(red: 0.51, green: 0.55, blue: 0.60, alpha: 1.0)
            showAvatar(true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        searchDidChange(textView.text)
    }
    
}
