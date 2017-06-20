//
//  HeaderCell.swift
//  TableViewMVVM
//
//  Created by Pablo Dominé on 20/6/17.
//  Copyright © 2017 Pablo Dominé. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(header: HeaderView, section: Int)
}

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    
    weak var delegate: HeaderViewDelegate?
    
    var section: Int = 0
    
    var item: ProfileViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            titleLabel.text = item.sectionTitle
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    func setCollapsed(collapsed: Bool) {
        arrowLabel.rotate(collapsed ? 0.0 : .pi)
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
}
