//
//  ViewController.swift
//  Journal_Practice
//
//  Created by 이의현 on 2018. 8. 25..
//  Copyright © 2018년 이의현. All rights reserved.
//


import UIKit

// Date()를 원하는 방식으로 수정
extension DateFormatter {
    // 재사용을 위해 정적변수로 선언
    static var entryDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }() // closure 바로 리턴하는 문법
}

class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let journal: Journal = InMemoryJournal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DateFormatter 사용
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "IBOutlet으로 연결한 Textview"
    }

    @IBAction func saveEntry(_ sender: Any) {
        //print("추가 전: ", journal.recentEntries(max: 10).count)
        let entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
        journal.add(entry)
        
        //print("추가 후: ", journal.recentEntries(max: 10).count)
    }
    

}

