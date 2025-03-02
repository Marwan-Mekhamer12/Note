//
//  NewTabVC.swift
//  Note
//
//  Created by Marwan Mekhamer on 08/08/2024.
//

import UIKit

class NewTabVC: UIViewController {
    
     var completion : ((String, String) -> Void)?
    
    private let textField : UITextField = {
      let textField = UITextField()
        textField.placeholder = "Add Title Note..."
        textField.font = .systemFont(ofSize: 20)
        return textField
    }()
    
    private let textView : UITextView = {
        let textview = UITextView()
        textview.font = .systemFont(ofSize: 22)
        return textview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        configure()
        view.addSubview(textField)
        view.addSubview(textView)
        textField.becomeFirstResponder()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textField.frame = CGRect(x: 10, y: 100, width: view.frame.width, height: 23)
        textView.frame = CGRect(x: 0, y: 130, width: view.frame.width, height: view.frame.height-30)
    }
    
    private func configure(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTabSave))
    }
    
    @objc private func didTabSave(){
        if let text = textField.text, let textview = textView.text,
           !text.isEmpty, !textview.isEmpty{
            completion?(text, textView.text)
        }
    }

}
