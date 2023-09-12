//
//  ViewController.swift
//  Kombine
//
//  Created by Gabriel Puppi on 10/09/23.
//

import UIKit
import Combine
import CombineCocoa

class TagListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    
    private let viewModel = TagListViewModel()
    private let output = PassthroughSubject<TagListViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private var tags: [Tag] = []
    private var selectedTags: Set<Int> = []
    
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
        button.addTarget(self, action: #selector(confirmButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.bgColor
        setupSubviews()
        setupTableView()
        setupLayout()
        observe()
        output.send(.viewDidLoad)
    }
    
    private func observe() {
        headerView.eventPublisher.sink { [weak self] event in
            switch event {
            case .resetDidTap:
                self?.output.send(.onResetTap)
            }
        }.store(in: &cancellables)
        
        viewModel.transform(input: output.eraseToAnyPublisher()).sink { [unowned self] event in
            switch event {
            case .setTags(let tags):
                self.tags = tags
            case let .updateView(tags, selected):
                self.tags = tags
                self.selectedTags = selected
                self.tagListView.reloadData()
            case let .showAlert(title, message):
                        // Display an alert with the provided title and message
                        self.presentAlert(title: title, message: message)
            }
        }.store(in: &cancellables)
    }
    
    
    private func setupTableView() {
        tagListView.isScrollEnabled = false
        tagListView.delegate = self
        tagListView.dataSource = self
        tagListView.dragInteractionEnabled = true
        tagListView.dragDelegate = self
        tagListView.dropDelegate = self
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
    
    @objc private func confirmButtonDidTap(_ sender: UIButton) {
        output.send(.onConfirmTap)
    }
    
    private func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagListItemView") as! TagListItemView
        let tag = tags[indexPath.item]
        cell.configureCell(tag: tag, isSelected: selectedTags.contains(tag.id))
        cell.eventPublisher.sink { [weak self] event in
            self?.output.send(.OnTagsCellEvent(event: .selectDidTap, tag: tag))
        }.store(in: &cell.cancellables)
        return cell
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let tag = tags[indexPath.row]
        let itemProvider = NSItemProvider(object: NSString(string: "\(tag.id)"))
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = tag
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        if let tag = coordinator.items.first?.dragItem.localObject as? Tag {
            var newTagsOrder = tags
            newTagsOrder.removeAll { $0 == tag }
            newTagsOrder.insert(tag, at: destinationIndexPath.row)
            
            // Notify the view model with the updated order
            output.send(.onTagsReorder(newOrder: newTagsOrder))
        }
        tagListView.reloadData()
    }
}

