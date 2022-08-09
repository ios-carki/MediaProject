//
//  MainViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/09.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var mainTableView: UITableView!
    
    let color: [UIColor] = [.red, .systemPink, .lightGray, .yellow, .black]
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](51...60),
        [Int](61...70),
        [Int](71...80),
        [Int](81...90)
    ]
    var headerTextArr: [String] = ["Carki님이 좋아할 만한 컨텐츠", "지금 뜨고있는 컨텐츠", "인싸들이 챙겨보는 컨텐츠", "SeSAC 추천 컨텐츠", "재미없는 컨텐츠", "스릴러 추천 컨텐츠", "여러번 보게되는 컨텐츠"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell() }
        cell.backgroundColor = .yellow
        cell.titleLabel.text = "\(headerTextArr[indexPath.section])"
        cell.customCollectionView.backgroundColor = .lightGray
        cell.customCollectionView.delegate = self
        cell.customCollectionView.dataSource = self
        cell.customCollectionView.tag = indexPath.section // 각 셀 구분 짓기
        cell.customCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return numberList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        cell.cardView.posterImageView.backgroundColor = .black
        cell.cardView.contentLabel.textColor = .white
        cell.cardView.contentLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
        
        return cell
    }
    
}
