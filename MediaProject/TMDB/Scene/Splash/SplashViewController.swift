//
//  SplashViewController.swift
//  MediaProject
//
//  Created by Carki on 2023/01/06.
//

import UIKit

final class SplashViewController: UIViewController {
    private let mainView = SplashView()
    private let modelData = APIService()
    private var myData: [dataResults] = []
    private var tvID: Int?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIRequest()
    }
    
    private func APIRequest() {
        modelData.requestAPI { statusCode, data in
            switch statusCode {
            case 200:
                print("데이터 담기 성공 ✅✅✅✅✅")
                self.myData = data.results
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self.changeRootVC()
                }
                return
            default:
                print("error")
            }
        }
    }
    
//    private func creditAPIRequest() {
//        modelData.requestCreditAPI(mediaID: <#T##String#>, completionHanlder: <#T##(Int, TMDBCredits) -> ()#>)
//    }
    
    private func changeRootVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let vc = MediaMainViewController()
        vc.receivedData = myData
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()

    }
    
}
