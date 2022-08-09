//
//  CardCollectionViewCell.swift
//  MediaProject
//
//  Created by Carki on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .lightGray
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
        cardView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        cardView.layer.borderColor = UIColor.green.cgColor
        cardView.layer.borderWidth = 5
    }

}
