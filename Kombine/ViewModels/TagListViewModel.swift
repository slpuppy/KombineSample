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
    }
    
    enum Output {
        case setTags(tags:[Tag])
        case updateView(tagsOrder:[Tag], selectedTags:Set<Int>)
    }
    
    private let output = PassthroughSubject<TagListViewModel.Output, Never>()
    
    @Published private var tags: [Tag] = Tag.allTags
    @Published private var selected: [Tag : Bool] = [:]
    
    var cancellables = Set<AnyCancellable>()
    
    private var selectedTags: Set<Int> {
      let array = selected.filter { $0.value == true }.map { $0.key.id }
      return Set(array)
    }
    
    init() {
        observe()
        for tag in Tag.allTags {
                selected[tag] = true
            }
            output.send(.updateView(tagsOrder: Tag.allTags, selectedTags: selectedTags))
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [unowned self] event in
          switch event {
          
          case .viewDidLoad:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
                output.send(.setTags(tags: Tag.allTags))
                output.send(.updateView(tagsOrder: Tag.allTags, selectedTags: selectedTags))
            }
          case .onResetTap:
              selected.removeAll()
              output.send(.updateView(tagsOrder: Tag.allTags, selectedTags: selectedTags))
          case .OnTagsCellEvent(event: .selectDidTap, let tag):
              if let value = selected[tag] {
                  selected[tag] = !value
              } else {
                  selected.updateValue(false, forKey: tag)
              }
              output.send(.updateView(tagsOrder: tags, selectedTags: selectedTags))
          case .onTagsReorder(newOrder: tags.shuffled()):
              break
          default:
              break
          }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
      }
    
    private func observe() {
        $tags.dropFirst().sink { tag in
            print(tag)
        }.store(in: &cancellables)
}
    
    
}
