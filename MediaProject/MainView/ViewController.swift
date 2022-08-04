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
    var votecount: String
    var title: String
    var overview: String
    
    init(image: String, votecount: String, title: String, overview: String) {
        self.image = image
        self.votecount = votecount
        self.title = title
        self.overview = overview
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var tvDataList: [tvData] = []
    
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
                    let newData = tvData(image: item["poster_path"].stringValue, votecount: item["vote_count"].stringValue, title: item["name"].stringValue, overview: item["overview"].stringValue)

                    tvDataList.append(newData)
                }
                

            case .failure(let error):
                print(error)
            }
            mainCollectionView.reloadData()
            
            
        }
    }

}

     

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return tvDataList.count
    }

        

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
//        viewShadow(viewName: cell)
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(tvDataList[indexPath.item].image)")
        
        cell.mainTitleLabel.text = tvDataList[indexPath.item].title
        cell.mainImageView.kf.setImage(with: url)
        cell.starRatePointLabel.text = tvDataList[indexPath.item].votecount
        cell.mainActorLabel.text = tvDataList[indexPath.item].overview
        print(tvDataList)
        
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
