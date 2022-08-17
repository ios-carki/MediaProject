//
//  ThirdViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/16.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var startViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startViewButton.setTitle("시작하기!", for: .normal)
        startViewButton.backgroundColor = .lightGray
        startViewButton.setTitleColor(.black, for: .normal)
        startViewButton.layer.cornerRadius = 10
        startViewButton.layer.borderWidth = 1

        
    }
    
    @IBAction func startViewButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        print(sb)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        print(vc)
        let nav = UINavigationController(rootViewController: vc)
        print(nav)
        
        navigationController?.pushViewController(vc, animated: true)//push 화면전환
        
        UserDefaults.standard.set(true, forKey: "First")
        
//        self.present(nav, animated: false)
    }
    
}
