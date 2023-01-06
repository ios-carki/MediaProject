//
//  MediaMainView.swift
//  MediaProject
//
//  Created by Carki on 2023/01/05.
//

import UIKit

import SnapKit

final class MediaMainView: BaseView {
    let mediaCollectionView: UICollectionView = {
//        let spacing: CGFloat = 12
//        let width = (UIScreen.main.bounds.width - spacing * 2)
//
//        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(280))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(spacing), top: .fixed(spacing), trailing: .fixed(spacing), bottom: .fixed(spacing))
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: item.layoutSize.heightDimension)
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
//        let layout = UICollectionViewCompositionalLayout(section: section)
//
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        return view
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - spacing * 2)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: 400)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    override func configureUI() {
        self.addSubview(mediaCollectionView)
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        mediaCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
