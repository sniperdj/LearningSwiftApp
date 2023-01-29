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
        return everydayOneLabel
    }()
    
    lazy var everydayOneAuthorLabel: UILabel = {
        let everydayOneAuthorLabel = UILabel()
        everydayOneAuthorLabel.font = UIFont.systemFont(ofSize: 14.0)
        everydayOneAuthorLabel.textColor = UIColor.gray
        return everydayOneAuthorLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(everydayOneLabel)
        contentView.addSubview(everydayOneAuthorLabel)

        everydayOneLabel.frame = CGRect(x: 10, y: 10, width: ConstSize.screenWidth - 20, height: 80)
        everydayOneAuthorLabel.frame = CGRect(x: 10, y: 100, width: 200, height: 30)

        everydayOneLabel.text = "每日一句"
    }
    
    func configCell(everydayOne: EverydayOne) {
        everydayOneLabel.text = everydayOne.content
        everydayOneAuthorLabel.text = everydayOne.author
    }
}
