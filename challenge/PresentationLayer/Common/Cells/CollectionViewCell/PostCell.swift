//
//  NewsfeedCell.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//


import UIKit

class PostCell: UICollectionViewCell {
    
    override var bounds: CGRect {
        didSet {
            layoutView()
        }
    }
    
    public var action: () -> () = {}
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10.0
    private var fillColor: UIColor = .white
    
    // MARK: HeaderOfPost
    private lazy var headerOfPostView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = imageView.layer.contentsScale
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.18, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    // MARK: Text Block
    private lazy var textBlockView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.19, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        let paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineSpacing = 4
        //        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium),
            NSAttributedString.Key.backgroundColor: UIColor.white,
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.32, green: 0.54, blue: 0.80, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Показать полностью...", attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
        
        button.addTarget(self, action: #selector(expandButtonDidTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Carousel
    private lazy var carouselView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: ActionsBar
    private lazy var actionsBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: ActionsBar - Like
    private lazy var likeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var likeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "ic_like")
        return imageView
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    // MARK: ActionsBar - Comment
    private lazy var commentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var commentIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "ic_comment")
        return imageView
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    // MARK: ActionsBar - Share
    private lazy var shareView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var shareIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "ic_share")
        return imageView
    }()
    
    private lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    // MARK: ActionsBar - Views
    private lazy var viewsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var viewsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "ic_views")
        return imageView
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.66, green: 0.68, blue: 0.7, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var textBlockHeightConstraint = self.textBlockView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var carouselHeightConstraint = self.carouselView.heightAnchor.constraint(equalToConstant: 0)
    
    private lazy var likeViewWidthConstraint = self.likeView.widthAnchor.constraint(equalToConstant: 76)
    private lazy var commentViewWidthConstraint = self.commentView.widthAnchor.constraint(equalToConstant: 76)
    private lazy var shareViewWidthConstraint = self.shareView.widthAnchor.constraint(equalToConstant: 76)
    private lazy var viewsViewWidthConstraint = self.viewsView.widthAnchor.constraint(equalToConstant: 76)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(post: Post, isExpanded: Bool, width: CGFloat) {
        nameLabel.text = post.owner?.name
        
        if let photo = post.owner?.photo {
            avatarImageView.download(from: photo)
        }
        
        if let photo = post.attachments.filter({ $0.photo != nil }).first?.photo {
            if let photoWidth = photo.width, let photoHeight = photo.height, let  photoSrc = photo.srcBig {
                carouselView.download(from: photoSrc)
                
                let scale = CGFloat(photoHeight) / CGFloat(photoWidth)
                carouselHeightConstraint.constant = width * scale
            } else {
                carouselHeightConstraint.constant = 0
            }
        } else {
            carouselHeightConstraint.constant = 0
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(post.date))
        dateLabel.text = date.pretty
        
        if let text = post.text {
            textLabel.text = text
            
            let font = textLabel.font!
            let rect = NSString(string: text)
                .boundingRect(
                    with: CGSize(
                        width: width - 24,
                        height: .greatestFiniteMagnitude
                    ),
                    options: .usesLineFragmentOrigin,
                    attributes: [.font: font], context: nil)
            
            if !isExpanded && rect.height / font.lineHeight > 8 {
                let sixLineHeight = (font.lineHeight * 6)
                textLabel.numberOfLines = 6
                textBlockHeightConstraint.constant = sixLineHeight + 22
                expandButton.isHidden = false
            } else {
                textLabel.numberOfLines = 0
                textBlockHeightConstraint.constant = rect.height
                expandButton.isHidden = true
            }
        } else {
            textBlockHeightConstraint.constant = 0
        }
        
        if let likes = post.likes {
            likeLabel.text = "\(likes.count ?? 0)"
            likeViewWidthConstraint.constant = 76
        } else {
            likeViewWidthConstraint.constant = 0
        }
        
        if let comments = post.comments {
            commentLabel.text = "\(comments.count ?? 0)"
            commentViewWidthConstraint.constant = 76
        } else {
            commentViewWidthConstraint.constant = 0
        }
        
        if let reposts = post.reposts {
            shareLabel.text = "\(reposts.count ?? 0)"
            shareViewWidthConstraint.constant = 76
        } else {
            shareViewWidthConstraint.constant = 0
        }
        
//        if let views = post.views {
//            viewsLabel.text = "\(views.count ?? 0)"
//            viewsViewWidthConstraint.constant = 76
//        } else {
//            viewsViewWidthConstraint.constant = 0
//        }
    }
    
    @objc func expandButtonDidTapped() {
        self.action()
    }
    
    private func configure() {
        clipsToBounds = false
        layer.cornerRadius = cornerRadius
    }
    
    private func layoutView() {
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.shouldRasterize = true
        self.contentView.layer.rasterizationScale = self.contentView.layer.contentsScale
        
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.4, blue: 0.44, alpha: 0.07).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 24.0)
        self.layer.shadowRadius = 18.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = self.layer.contentsScale
    }
    
    private func setupView() {
        addSubview(headerOfPostView)
        headerOfPostView.addSubview(avatarImageView)
        headerOfPostView.addSubview(nameLabel)
        headerOfPostView.addSubview(dateLabel)
        
        addSubview(textBlockView)
        textBlockView.addSubview(textLabel)
        textBlockView.addSubview(expandButton)
        
        addSubview(carouselView)
        addSubview(actionsBarView)
        
        actionsBarView.addSubview(likeView)
        likeView.addSubview(likeIcon)
        likeView.addSubview(likeLabel)
        
        actionsBarView.addSubview(commentView)
        commentView.addSubview(commentIcon)
        commentView.addSubview(commentLabel)
        
        actionsBarView.addSubview(shareView)
        shareView.addSubview(shareIcon)
        shareView.addSubview(shareLabel)
        
        actionsBarView.addSubview(viewsView)
        viewsView.addSubview(viewsIcon)
        viewsView.addSubview(viewsLabel)
    }
    
    private func setupConstraint() {
        headerOfPostView.translatesAutoresizingMaskIntoConstraints = false
        headerOfPostView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        headerOfPostView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        headerOfPostView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        headerOfPostView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: headerOfPostView.topAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: headerOfPostView.leadingAnchor).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: headerOfPostView.bottomAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: headerOfPostView.topAnchor, constant: 2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: headerOfPostView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: headerOfPostView.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        textBlockView.translatesAutoresizingMaskIntoConstraints = false
        textBlockView.topAnchor.constraint(equalTo: headerOfPostView.bottomAnchor, constant: 10).isActive = true
        textBlockView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        textBlockView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        textBlockHeightConstraint.isActive = true
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: textBlockView.topAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: textBlockView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: textBlockView.trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: textBlockView.bottomAnchor, constant: -22)
        
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.bottomAnchor.constraint(equalTo: textBlockView.bottomAnchor).isActive = true
        expandButton.leadingAnchor.constraint(equalTo: textBlockView.leadingAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        carouselView.topAnchor.constraint(equalTo: textBlockView.bottomAnchor, constant: 6).isActive = true
        carouselView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        carouselView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        carouselHeightConstraint.isActive = true
        
        actionsBarView.translatesAutoresizingMaskIntoConstraints = false
        actionsBarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        actionsBarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        actionsBarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        actionsBarView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        likeView.translatesAutoresizingMaskIntoConstraints = false
        likeView.bottomAnchor.constraint(equalTo: actionsBarView.bottomAnchor).isActive = true
        likeView.leadingAnchor.constraint(equalTo: actionsBarView.leadingAnchor).isActive = true
        likeView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeViewWidthConstraint.isActive = true
        
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        likeIcon.leadingAnchor.constraint(equalTo: likeView.leadingAnchor, constant: 16).isActive = true
        likeIcon.centerYAnchor.constraint(equalTo: likeView.centerYAnchor).isActive = true
        likeIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        likeIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 4).isActive = true
        likeLabel.centerYAnchor.constraint(equalTo: likeView.centerYAnchor).isActive = true
        
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentView.bottomAnchor.constraint(equalTo: actionsBarView.bottomAnchor).isActive = true
        commentView.leadingAnchor.constraint(equalTo: likeView.trailingAnchor).isActive = true
        commentView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        commentViewWidthConstraint.isActive = true
        
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        commentIcon.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 16).isActive = true
        commentIcon.centerYAnchor.constraint(equalTo: commentView.centerYAnchor).isActive = true
        commentIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        commentIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 4).isActive = true
        commentLabel.centerYAnchor.constraint(equalTo: commentView.centerYAnchor).isActive = true
        
        shareView.translatesAutoresizingMaskIntoConstraints = false
        shareView.bottomAnchor.constraint(equalTo: actionsBarView.bottomAnchor).isActive = true
        shareView.leadingAnchor.constraint(equalTo: commentView.trailingAnchor).isActive = true
        shareView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        shareViewWidthConstraint.isActive = true
        
        shareIcon.translatesAutoresizingMaskIntoConstraints = false
        shareIcon.leadingAnchor.constraint(equalTo: shareView.leadingAnchor, constant: 16).isActive = true
        shareIcon.centerYAnchor.constraint(equalTo: shareView.centerYAnchor).isActive = true
        shareIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        shareIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
        shareLabel.leadingAnchor.constraint(equalTo: shareIcon.trailingAnchor, constant: 4).isActive = true
        shareLabel.centerYAnchor.constraint(equalTo: shareView.centerYAnchor).isActive = true
        
        viewsView.translatesAutoresizingMaskIntoConstraints = false
        viewsView.bottomAnchor.constraint(equalTo: actionsBarView.bottomAnchor).isActive = true
        viewsView.trailingAnchor.constraint(equalTo: actionsBarView.trailingAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        viewsViewWidthConstraint.isActive = true
        
        viewsIcon.translatesAutoresizingMaskIntoConstraints = false
        viewsIcon.leadingAnchor.constraint(equalTo: viewsView.leadingAnchor, constant: 16).isActive = true
        viewsIcon.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor).isActive = true
        viewsIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        viewsIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.leadingAnchor.constraint(equalTo: viewsIcon.trailingAnchor, constant: 2).isActive = true
        viewsLabel.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor).isActive = true
    }
    
}
