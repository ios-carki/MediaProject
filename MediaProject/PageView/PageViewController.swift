//
//  PageViewController.swift
//  MediaProject
//
//  Created by Carki on 2022/08/16.
//

import UIKit

class PageViewController: UIPageViewController {

    
    var pageViewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        createPageViewController()
        configurePageViewController()
    }
    
    func createPageViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let fist = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: fist) else { return 0 }
        
        print("=====", index)
        
        return index
    }
    
}
