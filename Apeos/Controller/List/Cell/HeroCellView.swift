//
//  HeroCellView.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 27/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import Kingfisher

public class HeroCellView: UIView, ViewModelOwner {
    
    let contentView: UIView
    let imageView: UIImageView
    let titleLabel: UILabel

    public var isSelected: Bool = false
    
    private var gradientLayer: CAGradientLayer
    
    public var viewModel: HeroCellViewModel? {
        didSet {
            update()
        }
    }
    
    public override init(frame: CGRect) {
        contentView = UIView()
        imageView = UIImageView()
        titleLabel = UILabel()
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
        titleLabel.text = nil
    }
    
    private func update() {
        
        if let url = viewModel?.url {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: ImageResource(downloadURL: url))
        }
        
        titleLabel.text = viewModel?.name

    }
    
}

extension HeroCellView: ViewCodable {
    
    public func buildHierarchy() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    public func buildConstraints() {
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 180),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
        ])
        
    }
    
    public func configure() {
        backgroundColor = .clear
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        contentView.layer.cornerRadius = 6.0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 4.0
        
        imageView.layer.cornerRadius = 6.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.addSublayer(gradientLayer)
        
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
}
