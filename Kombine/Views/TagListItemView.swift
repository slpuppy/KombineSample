//
//  TagListItemView.swift
//  Kombine
//
//  Created by Gabriel Puppi on 11/09/23.
//

import UIKit
import SnapKit
import Combine

class TagListItemView: UITableViewCell {
    
    private let eventSubject = PassthroughSubject<TagCellEvent, Never>()
    
    var eventPublisher: AnyPublisher<TagCellEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    
    var cancellables = Set<AnyCancellable>()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var dragImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "line.3.horizontal")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.grayColor
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables = Set<AnyCancellable>()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectButtonDidTap(_ sender: UIButton) {
        eventSubject.send(.selectDidTap)
    }
    
    func configureCell(tag: Tag, isSelected: Bool) {
        self.tagLabel.text = tag.name
        self.checkButton.tintColor = isSelected ? Colors.blueColor : Colors.grayColor
        self.checkButton.setImage(isSelected ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle"), for: .normal)
    }
    
    private func setupSubviews() {
        self.contentView.addSubview(checkButton)
        self.contentView.addSubview(tagLabel)
        self.contentView.addSubview(dragImage)
    }
    
    private func setupLayout() {
        
        self.contentView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(42)
        }
        
        self.checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        self.tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(16)
            make.centerY.equalTo(checkButton.snp.centerY)
        }
        
        self.dragImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
}

