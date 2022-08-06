//
//  DetailsViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/06.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class DetailsViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var mediaNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mediaNameLabel.text = UserDefaults.standard.value(forKey: "title") as! String

        
    }
    

}
