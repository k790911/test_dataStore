//
//  ViewController.swift
//  test_dataStore
//
//  Created by 김재훈 on 2022/01/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTextField: UITextField!
    @IBOutlet var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DataManager.shared.fetchMemo()
        myLabel.text = DataManager.shared.memoList[1].title ?? "0"
    }

    @IBAction func myButton(_ sender: UIButton) {
        //myLabel.text = myTextField.text
        let memo = myTextField.text
        DataManager.shared.addNewMemo(memo)
    }
    
}

