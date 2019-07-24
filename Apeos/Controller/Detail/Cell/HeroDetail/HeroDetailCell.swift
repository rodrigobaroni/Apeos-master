//
//  HeroDetailCell.swift
//  Apeos
//
//  Created by v.franca.nunes.silva on 16/06/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import Kingfisher

public class HeroDetailCell: UIView, ViewModelOwner {
    
    let contentView: UIView
    let imageView: UIImageView
    let titleLabel: UILabel
    let descriptionLabel: UILabel
    
    public var isSelected: Bool = false
    
    private var gradientLayer: CAGradientLayer
    
    public var viewModel: HeroDetailCellViewModel? {
        didSet {
            update()
        }
    }
    
    public override init(frame: CGRect) {
        contentView = UIView()
        imageView = UIImageView()
        titleLabel = UILabel()
        descriptionLabel = UILabel()
        gradientLayer = CAGradientLayer()
        super.init(frame: frame)
        setupView()
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    public func prepareForReuse() {
        imageView.image = nil
    }
    
    private func update() {
        
        if let url = viewModel?.url {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: ImageResource(downloadURL: url))
        } else {
            imageView.image = viewModel?.image
        }
        
        titleLabel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description?.htmlToString
        
    }
    
}

extension HeroDetailCell: ViewCodable {
    
    public func buildHierarchy() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    public func buildConstraints() {
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor, constant: -8),
        ])
        
    }
    
    public func configure() {
        gradientLayer.colors = [UIColor.black.cgColor,
                                UIColor.black.withAlphaComponent(0.4).cgColor]
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6.0
        imageView.clipsToBounds = true
        imageView.layer.addSublayer(gradientLayer)
    
        titleLabel.font = UIFont.withItalicAndBold(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
    }
    
    public func render() {
        contentView.backgroundColor = .clear
    }
    
}
