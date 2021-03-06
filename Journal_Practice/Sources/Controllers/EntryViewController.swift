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

let code = """
class EntryViewController: UIViewController {

@IBOutlet weak var dateLabel: UILabel!
@IBOutlet weak var textView: UITextView!
@IBOutlet weak var button: UIButton!

let journal: Journal = InMemoryJournal()
// 수정했을때에도 새로운 Entry로 가지 않도록
private var editingEntry: Entry?

// viewcontroller 한번만 호출
override func viewDidLoad() {
super.viewDidLoad()

// DateFormatter 사용
dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
textView.text = "IBOutlet으로 연결한 Textview"

// button 클릭시 작동하는 함수 코드 (IBAction 대신 작성)
button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
// touchUpInside 발생했을 때 해당 함수를 수행하라
// 버튼 영역에서 손을 뗀 시점
}


override func viewDidAppear(_ animated: Bool) {
super.viewDidAppear(animated)
// 키보드 띄우기
textView.becomeFirstResponder()
}

@objc func saveEntry(_ sender: Any) {
//print("추가 전: ", journal.recentEntries(max: 10).count)

// 옵셔널 바인딩: 편집중인 엔트리가 있을 경우
if let editing = editingEntry {
editing.text = textView.text
journal.update(editing)
//print("수정")
} else {
let entry: Entry = Entry(text: textView.text)
journal.add(entry)
editingEntry = entry
//print("저장")
}



let entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
journal.add(entry)

// 저장을 누르면 더이상 수정을 못하게
textView.isEditable = false
// 키보드 없애기
textView.resignFirstResponder()

// UIControlState: 이미지 상태 변화 가능
button.setTitle("수정", for: .normal)
button.addTarget(self, action: #selector(editEntry(_:)), for: .touchUpInside)

//print("추가 후: ", journal.recentEntries(max: 10).count)
}

@objc func editEntry(_ sender: Any) {
textView.isEditable = true
textView.becomeFirstResponder()
button.setTitle("저장", for: .normal)
button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
}

}




"""


class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    let journal: Journal = InMemoryJournal()
    // 수정했을때에도 새로운 Entry로 가지 않도록
    private var editingEntry: Entry?
    
    // viewcontroller 한번만 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DateFormatter 사용
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = code
        
        // button 클릭시 작동하는 함수 코드 (IBAction 대신 작성)
        button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        // touchUpInside 발생했을 때 해당 함수를 수행하라
        // 버튼 영역에서 손을 뗀 시점
        
        
        // Communication Pattern: Notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
        
    }
    
    @objc func keyboardWillShow(_ note: Notification) {
        // 키보드 높이를 알아내어 반영
        // Notification 객체 내부에는 userInfo 라는 딕셔너리가 존재함
        guard // 옵셔널 바인딩. guard let 바인딩
            let userInfo = note.userInfo, // UserInfo가 있는지
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue),
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval)
            else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        // 키보드에 따라 컨텐츠도 위로 올라가게끔
        
        
        //animation 넣기: 팝팝튀는 것을 방지하기 위해서
        UIView.animate(withDuration: duration){
            self.textViewBottomConstraint.constant = -keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ note: Notification) {
        guard // 옵셔널 바인딩. guard let 바인딩
            let userInfo = note.userInfo, // UserInfo가 있는지
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval)
            else { return }
    
        // 키보드에 따라 컨텐츠도 위로 올라가게끔
        UIView.animate(withDuration: duration){
            self.textViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 키보드 띄우기
        textView.becomeFirstResponder()
    }

    @objc func saveEntry(_ sender: Any) {
        //print("추가 전: ", journal.recentEntries(max: 10).count)
        
        // 옵셔널 바인딩: 편집중인 엔트리가 있을 경우
        if let editing = editingEntry {
            editing.text = textView.text
            journal.update(editing)
            //print("수정")
        } else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
            editingEntry = entry
            //print("저장")
        }
        
        
        
        let entry = Entry(id: UUID(), createdAt: Date(), text: textView.text)
        journal.add(entry)
        
        // 저장을 누르면 더이상 수정을 못하게
        textView.isEditable = false
        // 키보드 없애기
        textView.resignFirstResponder()
        
        // UIControlState: 이미지 상태 변화 가능
        button.setTitle("수정", for: .normal)
        button.addTarget(self, action: #selector(editEntry(_:)), for: .touchUpInside)
        
        //print("추가 후: ", journal.recentEntries(max: 10).count)
    }
    
    @objc func editEntry(_ sender: Any) {
        textView.isEditable = true
        textView.becomeFirstResponder()
        button.setTitle("저장", for: .normal)
        button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
    }

}

