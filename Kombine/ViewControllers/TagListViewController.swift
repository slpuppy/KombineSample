//
//  ViewController.swift
//  Kombine
//
//  Created by Gabriel Puppi on 10/09/23.
//

import UIKit

class TagListViewController: UIViewController {

    private var headerView = TagListHeaderView()
    private var tagListView = TagListView()
    private var confirmationButton = UIButton()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[
        headerView,
        tagListView
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        view.addSubview(vStackView)
    }

    private func setupLayout() {
        
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(16)
            make.top.equalTo(view.snp.topMargin).offset(16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(16)
        }
        
        headerView.snp.makeConstraints { make in
            
        }
        
        tagListView.snp.makeConstraints { make in
            
        }
        
        confirmationButton.snp.makeConstraints { make in
            
        }
    }
    
   

}

