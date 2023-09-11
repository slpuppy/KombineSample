//
//  TagListHeaderView.swift
//  Kombine
//
//  Created by Gabriel Puppi on 11/09/23.
//

import UIKit
import SnapKit

class TagListHeaderView: UIView {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Rubriques"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = Colors.textColor
        return label
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(Colors.textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = Colors.textColor.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = Colors.clearColor
        setupSubviews()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(headerLabel)
        self.addSubview(resetButton)
    }
    
    private func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        resetButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.centerY.equalTo(headerLabel.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(72)
        }
    }
}
