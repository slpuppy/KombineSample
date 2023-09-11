//
//  Tags.swift
//  Kombine
//
//  Created by Gabriel Puppi on 11/09/23.
//

import Foundation

struct Tag: Hashable {
    
    let name: String
    let id: Int
    
    static let allTags: [Tag] = [
        .init(name: "ACTIVEWEAR", id: 762),
        .init(name: "LULULEMON", id: 676),
        .init(name: "VINTAGE", id: 766),
        .init(name: "Y2K", id: 668),
        .init(name: "DESIGNER", id: 667),
        .init(name: "MODERN", id: 666),
        .init(name: "90S", id: 665),
        .init(name: "UPCYCLED", id: 664),
        .init(name: "COTTAGE", id: 663),
        .init(name: "FAIRY", id: 662),
        .init(name: "STREETWEAR", id: 661),
    ]
}












