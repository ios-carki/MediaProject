//
//  SecondViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/16.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.text = "다음 페이지에서 시작할 수 있습니다"
    }
    
}
