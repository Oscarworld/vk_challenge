//
//  NewsfeedCollectionView.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

class NewsfeedCollectionView: UICollectionView {
    
    public var searchDidChange: (_ text: String) -> () = { _ in }
    
    public var isExpanded: [Bool] = []
    
    public var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    public var searchString: String?
    public var avatarSrc: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    private let cellIdentifier  = "Cell"
    private let searchIdentifier = "Search"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        self.backgroundColor = .clear
        
        register(PostCell.self, forCellWithReuseIdentifier: cellIdentifier)
        register(SearchReusableView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: searchIdentifier)
        
        delegate = self
        dataSource = self
    }
    
    private func isExpanded(at index: IndexPath) -> Bool {
        guard index.row < isExpanded.count else {
            return false
        }
        
        return isExpanded[index.row]
    }
    
    private func expand(at index: IndexPath) {
        guard index.row < isExpanded.count else {
            return
        }
        
        isExpanded[index.row] = !isExpanded[index.row]
    }
    
}

// MARK: Implementation UICollectionViewDataSource
extension NewsfeedCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.row < self.posts.count,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PostCell
        else {
                return UICollectionViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.setCell(post: post, isExpanded: isExpanded(at: indexPath), width: collectionView.frame.width - 16)
        cell.action = { [weak self] in
            self?.expand(at: indexPath)
            UIView.animate(withDuration: 0.0, animations: { [weak self] in
                self?.reloadItems(at: [indexPath])
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: searchIdentifier,
                                                                             for: indexPath) as? SearchReusableView else {
                return UICollectionReusableView()
            }
            
            cell.setCell(search: searchString, src: avatarSrc)
            cell.searchDidChange = { [weak self] text in
                self?.searchDidChange(text)
            }
            
            return cell
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
}

// MARK: Implementation UICollectionViewDelegateFlowLayout
extension NewsfeedCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.row < self.posts.count else {
            return .zero
        }
        
        let post = posts[indexPath.row]
        
        var height: CGFloat = 12.0 + 36.0 + 10.0 + 6.0 + 4.0 + 44.0

        if let text = post.text {
            let font = UIFont.systemFont(ofSize: 15, weight: .regular)
            let rect = NSString(string: text)
                .boundingRect(
                    with: CGSize(
                        width: collectionView.frame.width - 40,
                        height: .greatestFiniteMagnitude
                    ),
                    options: .usesLineFragmentOrigin,
                    attributes: [.font: font], context: nil)
            if !isExpanded(at: indexPath) && rect.height / font.lineHeight > 8 {
                let sixLineHeight = (font.lineHeight * 6)
                height += sixLineHeight + 22
            } else {
                height += rect.height
            }
        }
        
        if let photo = post.attachments.filter({ $0.photo != nil }).first?.photo {
            if let photoWidth = photo.width, let photoHeight = photo.height {
                
                let scale = CGFloat(photoHeight) / CGFloat(photoWidth)
                height += scale * collectionView.frame.width - 16
            }
        }
        
        return CGSize(width: collectionView.frame.width - 16, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
}

