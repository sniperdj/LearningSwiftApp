//
//  MovieViewController.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/25.
//

import Foundation
import UIKit

class MovieViewController: BaseViewController {
    
    static let cellReuseId = "movieCell"
    
//    lazy var movieTableView: UITableView = {
//        let movieTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ConstSize.screenWidth, height: ConstSize.screenHeight), style: UITableView.Style.plain)
//        movieTableView.delegate = self
//        movieTableView.dataSource = self
//        movieTableView.register(UITableViewCell.self, forCellReuseIdentifier: MovieViewController.cellReuseId)
//        movieTableView.tableFooterView = UIView()
//        movieTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        movieTableView.backgroundColor = UIColor.white
//        return movieTableView
//    }()
//
//    lazy var movieList: Array = {
//      return Array<MovieItem>()
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        title = "电影"
//        view.addSubview(movieTableView)
        
//        fetchMovieList()
    }
    
}
