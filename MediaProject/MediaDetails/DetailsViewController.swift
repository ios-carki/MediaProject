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

struct idData {
    var id: Int
    
    init(id: Int) {
        self.id = id
        
    }
}

struct castData {
    var image: String
    var knownForDepartment: String
    var name: String
    var character: String
    var original_name: String
    
    init(image: String, knownForDepartment: String, name: String, character: String, original_name: String) {
        self.image = image
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.character = character
        self.original_name = original_name
    }
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var imageTintBackGround: UIImageView!
    
    @IBOutlet weak var mediaNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var mediaIDList: [idData] = []
    var castTableData: [castData] = []
    var receivePosterData: String?
    var receiveTitleData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var imageURL = URL(string: receivePosterData!)
        
//        var imageURL = URL(string:"https://image.tmdb.org/t/p/w500/\(UserDefaults.standard.string(forKey: "image")!)")
        
        var backImageURL = URL(string:"https://image.tmdb.org/t/p/w500/\(UserDefaults.standard.string(forKey: "backImage")!)")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        mediaNameLabel.text = receiveTitleData //값전달
        mediaNameLabel.textColor = .white
        mediaNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        //유저디폴트
        backgroundImageView.kf.setImage(with: backImageURL)
        backgroundImageView.contentMode = .scaleToFill
        imageTintBackGround.image = UIImage(named: "background")
        imageTintBackGround.contentMode = .scaleToFill
        posterImageView.kf.setImage(with: imageURL)
        posterImageView.contentMode = .scaleToFill
//        print("https://image.tmdb.org/t/p/w500/\(UserDefaults.standard.string(forKey: "image")!)")
        
//        tableJson()
        request()
    }
    
    func request() {
        
//        var urlID = mediaIDList 없어도 되나?
               var url = "https://api.themoviedb.org/3/tv/\(UserDefaults.standard.integer(forKey: "id"))/credits?api_key=\(APIKey.TMDB)"
               
       //        let url = "https://api.themoviedb.org/3/trending/tv/week?api_key=\(APIKey.TMDB)"
       //
       //        //validate - 유효성 검사
               
               AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
                   switch response.result {
                   case .success(let value):
                       let json = JSON(value)
       //                print("JSON: \(json)")
                       
                       for item in json["cast"].arrayValue {
       //                    let newData = idData(id: item["id"].stringValue)
                           let cast = castData(image: item["profile_path"].stringValue, knownForDepartment: item["known_for_department"].stringValue, name: item["name"].stringValue, character: item["character"].stringValue, original_name: item["original_name"].stringValue)
                           
                           self.castTableData.append(cast)
                       }
                       
                   case .failure(let error):
                       print(error)
                   }
                   
                   self.tableView.reloadData()
               }
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        
//
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(castTableData[indexPath.item].image)")
        
        cell.actorImageView.kf.setImage(with: imageURL)
        UserDefaults.standard.set(imageURL, forKey: "detailImage")
        
        cell.actorRoleLabel.text = castTableData[indexPath.item].character
        UserDefaults.standard.set(castTableData[indexPath.item].character, forKey: "detailActorRole")
        
        cell.inMediaName.text = castTableData[indexPath.item].name
        UserDefaults.standard.set(castTableData[indexPath.item].name, forKey: "detailMediaName")
        
        cell.actorJobLael.text = castTableData[indexPath.item].knownForDepartment
        UserDefaults.standard.set(castTableData[indexPath.item].knownForDepartment, forKey: "detailJob")
        
        cell.actorRealName.text = castTableData[indexPath.item].original_name
        UserDefaults.standard.set(castTableData[indexPath.item].original_name, forKey: "detailOriginalName")
    
        return cell
    }
    
    
    func tableJson() {
        
        let url = "https://api.themoviedb.org/3/trending/tv/week?api_key=\(APIKey.TMDB)"
        
        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let newData = idData(id: item["id"].intValue)
                    
                    self.mediaIDList.append(newData)
                }
                
                
                
            case .failure(let error):
                print(error)
            }
            
            self.tableView.reloadData()
        }

    }
    

}
