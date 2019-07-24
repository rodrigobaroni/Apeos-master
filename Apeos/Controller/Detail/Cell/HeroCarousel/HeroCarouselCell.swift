//
//  HeroCarouselCell.swift
//  Apeos
//
//  Created by v.franca.nunes.silva on 16/06/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

public class HeroCarouselCell: UIView, ViewModelOwner {
    
    let collectionView: UICollectionView
    
    public var isSelected: Bool = false
    
    private var layout: UICollectionViewFlowLayout
    typealias CharacterDetailCell = CollectionViewCell<HeroDetailCell, HeroDetailCellViewModel>
    
    public var viewModel: [HeroDetailCellViewModel]? {
        didSet {
            update()
        }
    }
    
    public override init(frame: CGRect) {
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func prepareForReuse() { }
    
    private func update() {
        collectionView.reloadData()
    }
    
}

extension HeroCarouselCell: ViewCodable {
    
    public func buildHierarchy() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
    }
    
    public func buildConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
    }
    
    public func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CharacterDetailCell.self)
        layout.scrollDirection = .horizontal
    }
    
    public func render() {
        collectionView.backgroundColor = .white
    }
    
}

extension HeroCarouselCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
}

extension HeroCarouselCell: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? Int()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterDetailCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.viewModel = viewModel?[indexPath.item]
        return cell
    }
    
}
