//
//  NoteTapVC.swift
//  Note
//
//  Created by Marwan Mekhamer on 08/08/2024.
//

import UIKit

class NoteTapVC: UIViewController, UITextViewDelegate {
    
    var textField : UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20)
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    var textView : UITextView = {
        let text = UITextView()
        text.font = .systemFont(ofSize: 22)
        return text
    }()
    
    var lbltitlenote = " "
    var txtsubview = " "
    
    var newData : ((String, String) -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        textView.delegate = self
        // Do any additional setup after loading the view.
        view.addSubview(textField)
        view.addSubview(textView)
        textField.text = lbltitlenote
        textView.text = txtsubview
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTabSaveData))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textField.frame = CGRect(x: 10, y: 100, width: view.frame.width, height: 30)
        textView.frame = CGRect(x: 0, y: 130, width: view.frame.width, height: view.frame.height-30)
    }
    
    @objc func didTabSaveData(){
        if let titleNote = textField.text, let text = textView.text,
           !titleNote.isEmpty, !text.isEmpty{
            newData?(titleNote, text)
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.isEditable == true{
            textView.text = txtsubview
        }
    }

}
