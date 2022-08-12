//
//  WebViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/08.
//

import UIKit
import WebKit

import Kingfisher

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL = "https://www.youtube.com/watch?v=\( UserDefaults.standard.string(forKey: "youtubekey")!)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(destinationURL)
        openWebPage(url: destinationURL)
        
    }

    func openWebPage(url: String) {
        print(url)
        guard let url = URL(string: url) else {
            print("잘못된 URL 요청입니다.")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
