//
//  TabbarViewController.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/19.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.tabBar.tintColor = ConstColor.mainColor
        self.tabBar.barTintColor = UIColor.white
        
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem.title = "首页"
        homeNav.tabBarItem.image = UIImage(named: "tabbar_home")
        homeNav.tabBarItem.selectedImage = UIImage(named: "tabbar_home_selected")
        
        let categoryVC = ViewController()
        categoryVC.title = "影视"
        let categoryNav = UINavigationController(rootViewController: categoryVC)
        categoryNav.tabBarItem.title = "影视"
        categoryNav.tabBarItem.image = UIImage(named: "tabbar_play")
        categoryNav.tabBarItem.selectedImage = UIImage(named: "tabbar_play_selected")
        
        let cartVC = ViewController()
        cartVC.title = "美食"
        let cartNav = UINavigationController(rootViewController: cartVC)
        cartNav.tabBarItem.title = "美食"
        cartNav.tabBarItem.image = UIImage(named: "tabbar_food")
        cartNav.tabBarItem.selectedImage = UIImage(named: "tabbar_food_selected")
        
        let mineVC = ViewController()
        mineVC.title = "我的"
        let mineNav = UINavigationController(rootViewController: mineVC)
        mineNav.tabBarItem.title = "我的"
        mineNav.tabBarItem.image = UIImage(named: "tabbar_mine")
        mineNav.tabBarItem.selectedImage = UIImage(named: "tabbar_mine_selected")
        
        self.viewControllers = [homeNav, categoryNav, cartNav, mineNav]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
