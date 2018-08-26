//
//  TimelineViewController.swift
//  Journal_Practice
//
//  Created by 이의현 on 2018. 8. 26..
//  Copyright © 2018년 이의현. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var entryCountLabel: UILabel!
    
    
    override func viewDidLoad() { // 한번만 호출
        super.viewDidLoad()
        title = "프렌팅짱"
    }
    
    override func viewWillAppear(_ animated: Bool) { //왔다갔다 계속 호출
        super.viewWillAppear(animated)
        
        let journal = InMemoryEntryRepository.shared //싱글턴 패턴
        entryCountLabel.text = journal.numberOfEntries > 0 ? "엔트리 갯수: \(journal.numberOfEntries)" : "엔트리 없음"
    }
}
