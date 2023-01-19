//
//  HomeViewController.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/19.
//

import UIKit

class HomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange

        let label = UILabel(frame: CGRect(x: 0, y:240, width: ConstSize.screenWidth, height: 100))
        label.text = "这是一个首页"
        label.textColor = ConstColor.mainColor
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
    }
}
