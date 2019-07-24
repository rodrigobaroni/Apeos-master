//
//  ListView.swift
//  Apeos
//
//  Created by Rodrigo Alexis Garcia Baroni on 27/03/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import Kingfisher

public protocol ListViewDelegate: class {
    func prefetchHeros(with count: Int)
    func didSelect(_ indexPath: IndexPath)
}

public class ListView: UIView {
    
    let contentView: UIView
    let tableView: UITableView
    
    typealias HeroCell = TableViewCell<HeroCellView, HeroCellViewModel>
    
    public weak var delegate: ListViewDelegate?
    
    public var viewModel: ListViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    public override init(frame: CGRect) {
        contentView = UIView()
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

extension ListView: ViewCodable {
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(cellType: HeroCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
    }
    
    public func render() {
        tableView.backgroundColor = .clear
        contentView.backgroundColor = .white
//        contentView.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
    }
    
}

extension ListView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(indexPath)
    }
    
}

extension ListView: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characters.count ?? Int()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HeroCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = viewModel?.characters[indexPath.row]
        return cell
    }
    
}

extension ListView: UITableViewDataSourcePrefetching {
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isFetchRow), let indexPath = indexPaths.first {
            delegate?.prefetchHeros(with: indexPath.row + 1)
        }
    }
    
    private func isFetchRow(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (viewModel?.characters.count ?? Int()) - 1
    }
    
}


