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
    
    var environment: Environment = Environment() // 의존성객체
    
    // 세그로 이동전 이동할 뷰 컨트롤러 받아오기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
            entryVC?.environment = environment
            // 데이터 넘겨주기
        default:
            break
        }
    }
    
    
    override func viewDidLoad() { // 한번만 호출
        super.viewDidLoad()
        title = "프렌팅짱"
    }
    
    override func viewWillAppear(_ animated: Bool) { //왔다갔다 계속 호출
        super.viewWillAppear(animated)

        /*
        let journal = InMemoryEntryRepository.shared //싱글턴 패턴
        entryCountLabel.text = journal.numberOfEntries > 0 ? "엔트리 갯수: \(journal.numberOfEntries)" : "엔트리 없음"
         */
        
        let repo = environment.entryRepository
        entryCountLabel.text = repo.numberOfEntries > 0
            ? "엔트리 갯수: \(repo.numberOfEntries)"
            : "엔트리 없음"
    }
}
