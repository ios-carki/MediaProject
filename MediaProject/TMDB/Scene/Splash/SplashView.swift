//
//  SplashView.swift
//  MediaProject
//
//  Created by Carki on 2023/01/06.
//

import UIKit

import SnapKit

final class SplashView: BaseView {
    let logo: UILabel = {
        let view = UILabel()
        view.text = "Oh My TMDB"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 40)
        view.textAlignment = .center
        return view
    }()
    
    override func configureUI() {
        self.addSubview(logo)
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        logo.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
