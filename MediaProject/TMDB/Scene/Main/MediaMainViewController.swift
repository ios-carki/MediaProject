//
//  MediaMainViewController.swift
//  MediaProject
//
//  Created by Carki on 2023/01/05.
//

import UIKit
import Kingfisher

final class MediaMainViewController: UIViewController {
    private let mainView = MediaMainView()
    var receivedData: [dataResults] = []
    var posterImageURL: [URL] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("데이터 개수: ", receivedData.count)
        collectionSetting()
    }
    
    private func collectionSetting() {
        mainView.mediaCollectionView.register(MediaMainViewCell.self, forCellWithReuseIdentifier: MediaMainViewCell.identifier)
        mainView.mediaCollectionView.delegate = self
        mainView.mediaCollectionView.dataSource = self
    }
    
}

extension MediaMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receivedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaMainViewCell.identifier, for: indexPath) as? MediaMainViewCell else { return UICollectionViewCell() }
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(receivedData[indexPath.item].backdrop_path)")
        
        cell.mediaImage.kf.setImage(with:posterURL)
        cell.starLabel.text = "평점"
        cell.starPoint.text = String(receivedData[indexPath.row].vote_average)
        
        cell.titleLabel.text = receivedData[indexPath.row].name
        cell.actorLabel.text = receivedData[indexPath.row].overview
        
        
        return cell
    }
    
    
}
