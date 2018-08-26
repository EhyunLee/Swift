//
//  Environment.swift
//  Journal_Practice
//
//  Created by 이의현 on 2018. 8. 26..
//  Copyright © 2018년 이의현. All rights reserved.
//

import Foundation

class Environment {
    let entryRepository: EntryRepository
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository()) {
        self.entryRepository = entryRepository
    }
}
