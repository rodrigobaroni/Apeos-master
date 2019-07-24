//
//  DetailView.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 30/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import Kingfisher

public class DetailView: UIView {
    
    let scrollView: UIScrollView
    let contentView: UIView
    
    let tableView: UITableView
    typealias CharacterDetailCell = TableViewCell<HeroCarouselCell, [HeroDetailCellViewModel]>
    
    let imageView: UIImageView
    let descriptionLabel: UILabel
    
    let stackView: UIStackView
    
    public var viewModel: DetailViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    public override init(frame: CGRect) {
        scrollView = UIScrollView()
        contentView = UIView()
        imageView = UIImageView()
        descriptionLabel = UILabel()
        stackView = UIStackView()
        tableView = UITableView()
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        tableView.reloadData()
    }
    
}

extension DetailView: ViewCodable {
    
    public func buildHierarchy() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(tableView)
    }
    
    public func buildConstraints() {
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        tableView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    public func configure() {
        tableView.dataSource = self
        tableView.register(cellType: CharacterDetailCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    public func render() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
}

extension DetailView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.charactersDetail.count ?? Int()
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.characterTitleDetail[section]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterDetailCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = viewModel?.charactersDetail[indexPath.section]
        return cell
    }
    
}
