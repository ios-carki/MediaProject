//
//  WebViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/08.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON
import SwiftUI

struct videoData {
    var videokey: String
    
    init(videokey: String) {
        self.videokey = videokey
    }
}

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var youtubeData = "1"
    var receiveID = 0
    
    var destinationURL: String = URL.makeYoutubeEndPointString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubeVideo()
        print(#function)
        print("값이 있나\(destinationURL)")
        
//        DispatchQueue.main.async {
//            destinationURL += youtubeData
//        }
        print("값이 있나\(destinationURL)")
        openWebPage(url: destinationURL)
        print(destinationURL)
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
    
    func youtubeVideo() {
        print(#function)
        print("건너간 id: \(receiveID)")
//        var destinationURL = ""
        let url = "https://api.themoviedb.org/3/tv/\(receiveID)/videos?api_key=\(APIKey.TMDB)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200..<500).responseData { reponse in
           switch reponse.result {
           case .success(let value):
               let json = JSON(value)
               print(json)

               for item in json["results"][0].arrayValue {
                   
                   var keySetting = item["key"].stringValue
                   
                   print(keySetting)
               }
               
           case .failure(let error):
               print(error)
            }
        }
        print(destinationURL)
    }
    
    
    
}
