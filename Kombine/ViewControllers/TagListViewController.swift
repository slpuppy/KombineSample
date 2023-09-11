//
//  ViewController.swift
//  Kombine
//
//  Created by Gabriel Puppi on 10/09/23.
//

import UIKit

class TagListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    private var headerView = TagListHeaderView()
    private var tagListView = TagListView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[
        headerView,
        tagListView
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var confirmationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.accentColor
        button.layer.cornerRadius = 16
        button.setTitle("Confirm", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bgColor
        setupSubviews()
        setupTableView()
        setupLayout()
    }
    
    private func setupTableView() {
        
        tagListView.delegate = self
        tagListView.dataSource = self
    }
    
    private func setupSubviews() {
        view.addSubview(vStackView)
        view.addSubview(confirmationButton)
    }

    private func setupLayout() {
        
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.snp.topMargin)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        confirmationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(vStackView.snp.bottomMargin).offset(-32)
            make.leading.equalTo(vStackView.snp.leadingMargin).offset(16)
            make.trailing.equalTo(vStackView.snp.trailingMargin).offset(-16)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tags.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TagListItemView") as? TagListItemView {
            
            return cell
        }
        return UITableViewCell()
    }
    
   

}

