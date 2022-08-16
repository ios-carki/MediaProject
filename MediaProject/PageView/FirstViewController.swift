//
//  FirstViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var lineUiView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.numberOfLines = 0
        textLabel.alpha = 0
        textLabel.font = .boldSystemFont(ofSize: 25)
        textLabel.text = """
        안녕하세요!
        TMDB 프로젝트에 오신걸 환영합니다!
        """
        
        lineUiView.backgroundColor = .black
        lineUiView.alpha = 0
    
        UIView.animate(withDuration: 3) {
            self.textLabel.alpha = 1
        } completion: { _ in
            self.animateLineView()
        }
    }
    
    func animateLineView() {
        UIView.animate(withDuration: 2) {
            self.lineUiView.alpha = 1
        } completion: { _ in
            
        }

    }

}
    
    


