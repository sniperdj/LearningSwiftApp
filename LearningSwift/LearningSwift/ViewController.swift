//
//  ViewController.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let label = UILabel(frame: CGRect(x: 40, y:240, width: 100, height: 100))
        label.text = "Hello World"
        label.textColor = ConstColor.mainColor
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
    }

}

