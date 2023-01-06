//
//  MediaMainViewCell.swift
//  MediaProject
//
//  Created by Carki on 2023/01/05.
//

import UIKit

import SnapKit

final class MediaMainViewCell: BaseCollectionViewCell {
    static let identifier = "mediaCell"
    
    let contentsViews: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let mediaImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let youtubeURLButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.setImage(UIImage(systemName: "paperclip"), for: .normal)
        return view
    }()
    
    let starView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
    let starLabel: UILabel = {
        let view = UILabel()
        view.text = "평점"
        view.textColor = .white
        view.textAlignment = .center
        view.backgroundColor = .purple
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let starPoint: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.backgroundColor = .white
        view.font = .boldSystemFont(ofSize: 14)
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .black
        return view
    }()
    
    let actorLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .lightGray
        return view
    }()
    
    let boundaryLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let detailLable: UILabel = {
        let view = UILabel()
        view.text = "자세히 보기"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let detailImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        return view
    }()
    
    override func configureUI() {
        [starLabel, starPoint].forEach {
            starView.addArrangedSubview($0)
        }
        [mediaImage, youtubeURLButton, starView, titleLabel, actorLabel, boundaryLine, detailLable, detailImage].forEach {
            contentsViews.addSubview($0)
        }
        contentView.addSubview(contentsViews)
        contentView.backgroundColor = .white
    }
    
    override func setConstraints() {
        contentsViews.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(8)
        }
        
        mediaImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentsViews.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        
        youtubeURLButton.snp.makeConstraints { make in
            make.top.equalTo(contentsViews.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentsViews.safeAreaLayoutGuide).offset(-10)
            make.size.equalTo(50)
        }
        
        starView.snp.makeConstraints { make in
            make.leading.equalTo(contentsViews.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(mediaImage.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImage.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentsViews.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
        
        actorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentsViews.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(20)
        }
        
        boundaryLine.snp.makeConstraints { make in
            make.top.equalTo(actorLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentsViews.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(1)
        }
        
        detailLable.snp.makeConstraints { make in
            make.top.equalTo(boundaryLine.snp.bottom).offset(12)
            make.leading.equalTo(contentsViews.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(detailImage.snp.leading)
            make.bottom.equalTo(contentsViews.safeAreaLayoutGuide).offset(-8)
        }
        
        detailImage.snp.makeConstraints { make in
            make.centerY.equalTo(detailLable.snp.centerY)
            make.trailing.equalTo(contentsViews.safeAreaLayoutGuide).offset(-20)
            make.size.equalTo(20)
        }
    }
    
    
    
}
