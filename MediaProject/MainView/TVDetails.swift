//
//  TVDetails.swift
//  MediaProject
//
//  Created by Carki on 2022/08/05.
//

import Alamofire
import Kingfisher
import SwiftyJSON

struct TVMedia {
    var image: String
    var star: String
    var title: String
    var actor: String
    
}

struct tvDetails {
    let tv: [TVMedia] = [
        TVMedia(image: "", star: "3.3", title: "보더랜드", actor: "마동석")
        ]
}


