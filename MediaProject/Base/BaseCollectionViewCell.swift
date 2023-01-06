//
//  BaseCollectionViewCell.swift
//  MediaProject
//
//  Created by Carki on 2023/01/05.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    
    func setConstraints() { }
    
}
