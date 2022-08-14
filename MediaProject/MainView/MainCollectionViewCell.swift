//
//  MainCollectionViewCell.swift
//  MediaProject
//
//  Created by Carki on 2022/08/04.
//

import UIKit

import Alamofire
import SwiftyJSON

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var headerGenreLabel: UILabel!
    
    @IBOutlet weak var youtubeLinkButton: UIButton!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var starRateTextLabel: UILabel!
    @IBOutlet weak var starRatePointLabel: UILabel!
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainActorLabel: UILabel!
    
    @IBOutlet weak var boundaryView: UIView!
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let r : CGFloat = 88
        let g : CGFloat = 86
        let b : CGFloat = 207

        let color = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
        
        headerDateLabel.text = "120120210210"
        headerGenreLabel.text = "#crime"
        headerGenreLabel.font = .boldSystemFont(ofSize: 32)
        
        
        starRateTextLabel.text = "평점"
        starRateTextLabel.textColor = .white
        starRateTextLabel.textAlignment = .center
        starRateTextLabel.backgroundColor = color
        starRatePointLabel.textAlignment = .center
        mainImageView.contentMode = .scaleToFill
        mainTitleLabel.font = .boldSystemFont(ofSize: 20)
        mainActorLabel.font = .boldSystemFont(ofSize: 15)
        mainActorLabel.textColor = .lightGray
        mainActorLabel.numberOfLines = 1
        boundaryView.layer.borderWidth = 1
        boundaryView.layer.borderColor = UIColor.black.cgColor
        rightButton.setTitle("자세히 보기", for: .normal)
        rightButton.titleLabel?.font =  UIFont(name: "자세히 보기", size: 20)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.contentHorizontalAlignment = .left
        rightImage.image = UIImage(systemName: "chevron.right")
        rightImage.tintColor = .lightGray
        
        youtubeLinkButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        youtubeLinkButton.tintColor = .black
        youtubeLinkButton.layer.borderWidth = 1
        youtubeLinkButton.backgroundColor = .white
        youtubeLinkButton.layer.cornerRadius = 20
    }

    
}
