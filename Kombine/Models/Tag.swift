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
        .init(name: "ACTIVEWEAR", id: 000),
        .init(name: "LULULEMON", id: 001),
        .init(name: "VINTAGE", id: 002),
        .init(name: "Y2K", id: 003),
        .init(name: "DESIGNER", id: 004),
        .init(name: "MODERN", id: 005),
        .init(name: "90S", id: 006),
        .init(name: "UPCYCLED", id: 007),
        .init(name: "COTTAGE", id: 008),
        .init(name: "FAIRY", id: 009),
        .init(name: "STREETWEAR", id: 010),
    ]
}












