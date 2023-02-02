//
//  EveryDayOneCollectionCell.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/28.
//

import UIKit

class EveryDayOneCollectionCell: UICollectionViewCell {
    static let cellReuseId = "everydayOneCell"
    
    lazy var everydayOneLabel: UILabel = {
        let everydayOneLabel = UILabel()
        everydayOneLabel.font = UIFont.systemFont(ofSize: 16.0)
        everydayOneLabel.textColor = UIColor.black
        everydayOneLabel.numberOfLines = 0
        everydayOneLabel.textAlignment = .center
        return everydayOneLabel
    }()
    
    lazy var everydayOneAuthorLabel: UILabel = {
        let everydayOneAuthorLabel = UILabel()
        everydayOneAuthorLabel.font = UIFont.systemFont(ofSize: 14.0)
        everydayOneAuthorLabel.textColor = UIColor.gray
        return everydayOneAuthorLabel
    }()

    lazy var everydayBackgroundImageView: UIImageView = {
        let everydayBackgroundImageView = UIImageView()
        everydayBackgroundImageView.contentMode = .scaleAspectFill
        return everydayBackgroundImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // 背景图 
        contentView.addSubview(everydayBackgroundImageView)
        everydayBackgroundImageView.frame = contentView.bounds
        // 每日一句
        contentView.addSubview(everydayOneLabel)
        let y = HomeViewController.everyDayViewHeight - 60
        everydayOneLabel.frame = CGRect(x: 0, y: y, width: ConstSize.screenWidth, height: 60)
        let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        everydayOneLabel.backgroundColor = backgroundColor
        everydayOneLabel.text = "每日一句"
        everydayOneLabel.textColor = UIColor.white

        // 每日一句作者
        // everydayOneAuthorLabel.frame = CGRect(x: 10, y: 100, width: 200, height: 30)
    }
    
    func configCell(everydayOne: EverydayOne) {
        everydayOneLabel.text = everydayOne.content
        // everydayOneAuthorLabel.text = everydayOne.author
        everydayBackgroundImageView.image = UIImage(named: everydayOne.lunbo)
    }
}
