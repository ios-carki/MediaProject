//
//  ViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

struct tvData {
    var image: String
    var backImage: String
    var votecount: String
    var title: String
    var overview: String
    var id: Int
    
    init(image: String, backImage: String, votecount: String, title: String, overview: String, id: Int) {
        self.image = image
        self.backImage = backImage
        self.votecount = votecount
        self.title = title
        self.overview = overview
        self.id = id
    }
}

struct youtubeData {
    var youtubeKEY: String
    
    init(youtubeKEY: String) {
        self.youtubeKEY = youtubeKEY
        
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var tvDataList: [tvData] = []
    var youtubeList: [youtubeData] = []
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = false // 마지막 페이지 인지 체크 하는 flag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        let nibName = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: "MainCollectionViewCell")

        layoutSetting()
        request()
    }
    
    func layoutSetting() {
            let layout = UICollectionViewFlowLayout()
            let spacing : CGFloat = 30
            let layoutwidth = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: (layoutwidth), height: (layoutwidth / 2) * 3)
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            mainCollectionView.collectionViewLayout = layout
        }
    
    func request() {
        let url = "https://api.themoviedb.org/3/trending/tv/week?api_key=\(APIKey.TMDB)"
//        let imageurl = URL(string: "https://image.tmdb.org/t/p/w500/"+dataList[indexPath.item].posterImage)
        
        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { [self]response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let newData = tvData(image: item["poster_path"].stringValue, backImage: item["backdrop_path"].stringValue, votecount: item["vote_count"].stringValue, title: item["name"].stringValue, overview: item["overview"].stringValue, id: item["id"].intValue)

                    tvDataList.append(newData)
                }
                

            case .failure(let error):
                print(error)
            }
            mainCollectionView.reloadData()
            
            
        }
    }
    
    
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        
        let url = "https://api.themoviedb.org/3/tv/\(UserDefaults.standard.integer(forKey: "id"))/videos?api_key=\(APIKey.TMDB)"

        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("=================유튜브 제이슨=================")
                print("JSON: \(json)")
                
                for item in json["results"][0].arrayValue {
                    //이거
                    print(json["results"][0].arrayValue)
                    let newYoutubeData = youtubeData(youtubeKEY: item["key"].stringValue)
                    
                    self.youtubeList.append(newYoutubeData)
                }
                self.mainCollectionView.reloadData()


            case .failure(let error):
                print(error)
            }
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let nav = UINavigationController(rootViewController: vc)

        vc.destinationURL = "https://api.themoviedb.org/3/tv/\(UserDefaults.standard.integer(forKey: "id"))/videos?api_key=\(APIKey.TMDB)"
        
        self.navigationController?.pushViewController(vc, animated: true) //push 화면전환
        
    }
    

}

     

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let nav = UINavigationController(rootViewController: vc)
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(tvDataList[indexPath.item].image)")
        
        //값전달(title, posterImage)
        vc.receivePosterData = "https://image.tmdb.org/t/p/w500/\(tvDataList[indexPath.item].image)"
        vc.receiveTitleData = tvDataList[indexPath.item].title
        
        let urlBackGroundPoster = URL(string: "https://image.tmdb.org/t/p/w500/\(tvDataList[indexPath.item].backImage)")
        var backImageUD = UserDefaults.standard.set(tvDataList[indexPath.item].backImage, forKey: "backImage")
//        print(UserDefaults.standard.string(forKey: "backImage"))
//        vc.mediaNameLabel?.text = UserDefaults.standard.string(forKey: "title")
        
        
        
        UserDefaults.standard.set(tvDataList[indexPath.item].id, forKey: "id")//id 설정

        self.navigationController?.pushViewController(vc, animated: true) //push 화면전환
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0 {
            return tvDataList.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
//        viewShadow(viewName: cell)
        
        let urlPoster = URL(string: "https://image.tmdb.org/t/p/w500/\(tvDataList[indexPath.item].image)")
        
        
        cell.mainTitleLabel.text = tvDataList[indexPath.item].title
//        UserDefaults.standard.set(tvDataList[indexPath.item].title, forKey: "title")
        
        cell.mainImageView.kf.setImage(with: urlPoster)
        UserDefaults.standard.set(tvDataList[indexPath.item].image, forKey: "image")
        
        print(youtubeList)
//        UserDefaults.standard.set(youtubeList[indexPath.item].youtubeKEY, forKey: "youtubeKEY")
        
        
        cell.starRatePointLabel.text = tvDataList[indexPath.item].votecount
        cell.mainActorLabel.text = tvDataList[indexPath.item].overview
        return cell

    }
    
//    func viewShadow(viewName: UIView) {
//        viewName.layer.shadowColor = UIColor.black.cgColor // 색깔
//        viewName.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
//        viewName.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
//        viewName.layer.shadowRadius = 5 // 반경
//        viewName.layer.shadowOpacity = 0.7 // alpha값
//    }

}
