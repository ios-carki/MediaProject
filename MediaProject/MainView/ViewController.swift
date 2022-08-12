import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

struct tvData {
    var image: String
    var backImage: String
    var votecount: Double
    var title: String
    var overview: String
    var id: Int
    var youtubekey: String
//    var firstAirDate: String
//    var genreIds: Int
    
    init(image: String, backImage: String, votecount: Double, title: String, overview: String, id: Int, youtubekey: String) {
        self.image = image
        self.backImage = backImage
        self.votecount = votecount
        self.title = title
        self.overview = overview
        self.id = id
        self.youtubekey = youtubekey
//        self.firstAirDate = firstAirDate
//        self.genreIds = genreIds
    }
}

struct actorData {
    var actor: String

    init(actor: String) {
        self.actor = actor
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var tvDataList: [tvData] = []
    var actorList: [actorData] = []
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = false // 마지막 페이지 인지 체크 하는 flag
    var youtubeKeyList: [String] = []
    
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
        let topSpacing: CGFloat = 4
            let layoutwidth = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: (layoutwidth), height: (layoutwidth / 2) * 3.3)
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: topSpacing, left: spacing, bottom: spacing, right: spacing)
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
                print("이거좀 보자")
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let newData = tvData(image: item["poster_path"].stringValue, backImage: item["backdrop_path"].stringValue, votecount: item["vote_average"].doubleValue, title: item["name"].stringValue, overview: item["overview"].stringValue, id: item["id"].intValue, youtubekey: "")

                    tvDataList.append(newData)
                }
                

            case .failure(let error):
                print(error)
            }
            mainCollectionView.reloadData()
            
            
        }
    }
    
    func requestActor() {
        var url = "https://api.themoviedb.org/3/tv/\(UserDefaults.standard.integer(forKey: "id"))/credits?api_key=\(APIKey.TMDB)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
           switch response.result {
           case .success(let value):
               let json = JSON(value)
//                print("JSON: \(json)")
               
               for item in json["cast"].arrayValue {
                   let cast = actorData(actor: "original_name")
                   
                   self.actorList.append(cast)
               }
               
           case .failure(let error):
               print(error)
           }
           
       }
    }
    
    func youtube(){
//        guard let id = (UserDefaults.standard.string(forKey: "id") else{
//            return
//        }
        let url = "https://api.themoviedb.org/3/tv/\((UserDefaults.standard.string(forKey: "id")!))/videos?api_key=\(APIKey.TMDB)&language=en-US"
        
        print("확인영\(url)")
           AF.request(url, method: .get).validate().responseData(queue: .global()) { [self] reponse in
               switch reponse.result {
               case .success(let value):
                   let json = JSON(value)
                   print(json)
                   let youtubeKey = tvData(image: "", backImage: "", votecount: 0.0, title: "", overview: "", id: 0, youtubekey: json["results"][0]["key"].stringValue)
                   print(youtubeKey.youtubekey)
                   UserDefaults.standard.set(youtubeKey.youtubekey,forKey: "youtubekey")
                   tvDataList.append(youtubeKey)
                   
               case .failure(let error):
                   print(error)
                }
            }
    }
    
    
    @IBAction func teaserLinkButtonClicked(_ sender: UIButton) {
        youtube()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//        vc.destinationURL = "https://www.youtube.com/watch?v=\(UserDefaults.standard)"

        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .popover //풀스크린 모달방식
//        self.navigationController?.pushViewController(<#뷰컨트롤러 파일변수 vc#>, animated: true) //push 화면전환
        
        self.present(nav, animated: true)
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
        
//        print(UserDefaults.standard.integer(forKey: "id")) //id 데이터 잘 넘어갔는지 확인
        self.navigationController?.pushViewController(vc, animated: true) //push 화면전환
        
        let sb2 = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = sb2.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        UserDefaults.standard.set("https://www.youtube.com/watch?v=\(tvDataList[indexPath.item].youtubekey)", forKey: "key")
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
//        cell.layer.borderWidth = 1
//        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
//        viewShadow(viewName: cell)
        
        let urlPoster = URL(string: "https://image.tmdb.org/t/p/w500/\(tvDataList[indexPath.item].image)")
        
        
        cell.mainTitleLabel.text = tvDataList[indexPath.item].title
//        UserDefaults.standard.set(tvDataList[indexPath.item].title, forKey: "title")
        
        cell.mainImageView.kf.setImage(with: urlPoster)
        UserDefaults.standard.set(tvDataList[indexPath.item].image, forKey: "image")
        print(UserDefaults.standard.string(forKey: "image"))
        
        cell.starRatePointLabel.text = String(format: "%.1f", tvDataList[indexPath.item].votecount)
        
        print("엑터 리스트 개수\(tvDataList[indexPath.item])")
//        print("%%^%^%^%^ 리스트 개수\(actorList[indexPath.item])")
        
        
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
