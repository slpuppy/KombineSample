//
//  TagListViewModel.swift
//  Kombine
//
//  Created by Gabriel Puppi on 11/09/23.
//

import Foundation
import Combine

class TagListViewModel {
    
    enum Input {
        case viewDidLoad
        case OnTagsCellEvent(event: TagCellEvent, tag:Tag )
        case onTagsReorder(newOrder: [Tag])
        case onResetTap
        case onConfirmTap
    }
    
    enum Output {
        case setTags(tags:[Tag])
        case updateView(tagsOrder:[Tag], selectedTags:Set<Int>)
        case showAlert(title: String, message: String)
    }
    
    private let output = PassthroughSubject<TagListViewModel.Output, Never>()
    
    @Published private var tags: [Tag] = Tag.allTags
    @Published private var selected: [Tag : Bool] = [:]
    
    var cancellables = Set<AnyCancellable>()
    
    private var originalTagOrder: [Tag] = []
    
    private var selectedTags: Set<Int> {
        let array = selected.filter { $0.value == true }.map { $0.key.id }
        return Set(array)
    }
    
    init() {
        observe()
        resetSelected()
        originalTagOrder = Tag.allTags
        output.send(.updateView(tagsOrder: originalTagOrder, selectedTags: selectedTags))
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [unowned self] event in
            switch event {
            case .viewDidLoad:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                    output.send(.setTags(tags: Tag.allTags))
                    output.send(.updateView(tagsOrder: Tag.allTags, selectedTags: selectedTags))
                }
            case .onResetTap:
                resetSelected()
                tags = originalTagOrder
                output.send(.updateView(tagsOrder: tags, selectedTags: selectedTags))
            case .OnTagsCellEvent(event: .selectDidTap, let tag):
                if let value = selected[tag] {
                    selected[tag] = !value
                } else {
                    selected.updateValue(false, forKey: tag)
                }
                output.send(.updateView(tagsOrder: tags, selectedTags: selectedTags))
            case .onTagsReorder(let newOrder):
                tags = newOrder
                print("Updated tags: \(tags)")
                output.send(.updateView(tagsOrder: newOrder, selectedTags: selectedTags))
            case.onConfirmTap:
                if selectedTags.count >= 3 {
                    output.send(.showAlert(title: "Confirmation", message:"Tags saved"))
                } else {
                    output.send(.showAlert(title: "Not enough tags", message:"Please select at least 3 tags"))
                }
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func observe() {
        $tags.dropFirst().sink { tag in
            print(tag)
        }.store(in: &cancellables)
    }
    
    private func resetSelected(){
        for tag in Tag.allTags {
            selected[tag] = true
        }
    }
    
    
}
