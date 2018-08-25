//
//  Identifiable.swift
//  Journal_Practice
//
//  Created by 이의현 on 2018. 8. 25..
//  Copyright © 2018년 이의현. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: UUID { get }
}

extension Identifiable {
    func isIdentical(to other: Self) -> Bool {
        return id == other.id
    }
}
