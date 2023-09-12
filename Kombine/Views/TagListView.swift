//
//  TagListView.swift
//  Kombine
//
//  Created by Gabriel Puppi on 11/09/23.
//

import UIKit
import SnapKit

class TagListView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .insetGrouped)
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        self.register(TagListItemView.self, forCellReuseIdentifier: "TagListItemView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
