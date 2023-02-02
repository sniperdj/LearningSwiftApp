//
//  HomeViewController.swift
//  LearningSwift
//
//  Created by Sniper on 2023/1/19.
//

import UIKit
import Alamofire
import HandyJSON

class HomeViewController: BaseViewController {

    static let cellReuseId = "jokeCell"

    static let everyDayViewHeight: CGFloat = 140.0
    
    lazy var jokeTableView: UITableView = {
        let y: CGFloat = ConstSize.naviBarHeight + HomeViewController.everyDayViewHeight
        let jokeTableView = UITableView(frame: CGRect(x: 0, y: y, width: ConstSize.screenWidth, height: ConstSize.screenHeight - ConstSize.tabbarHeight - y), style: UITableView.Style.plain)
        jokeTableView.delegate = self
        jokeTableView.dataSource = self
        jokeTableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeViewController.cellReuseId)
        jokeTableView.tableFooterView = UIView()
        jokeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        jokeTableView.backgroundColor = UIColor.white
        return jokeTableView
    }()

    lazy var jokeList: Array = {
      return Array<JokeItem>()
    }()

    lazy var everydayOneList: Array = {
      return Array<EverydayOne>()
    }()

    lazy var everydayOneCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ConstSize.screenWidth, height: HomeViewController.everyDayViewHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let everydayOneCollectionView = UICollectionView(frame: CGRect(x: 0, y: ConstSize.naviBarHeight, width: ConstSize.screenWidth, height: HomeViewController.everyDayViewHeight), collectionViewLayout: layout)
        everydayOneCollectionView.delegate = self
        everydayOneCollectionView.dataSource = self
        everydayOneCollectionView.register(EveryDayOneCollectionCell.self, forCellWithReuseIdentifier: EveryDayOneCollectionCell.cellReuseId)
        everydayOneCollectionView.backgroundColor = UIColor.white
        everydayOneCollectionView.isPagingEnabled = true
        // everydayOneCollectionView.showsHorizontalScrollIndicator = false
        everydayOneCollectionView.bounces = false
        return everydayOneCollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        fetchJokeList()
        fetchEverydayOne()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.orange
        title = "首页"
        // 头部每日一句
        view.addSubview(everydayOneCollectionView)
        // 底部笑话列表
        view.addSubview(jokeTableView)
    }
}
// MARK: - Fetch Data
extension HomeViewController {
  func fetchJokeList() {

        let jokeListParams: [String : Any] = [
            "app_id": ConstEncryptValues.jokeAppId,
            "app_secret": ConstEncryptValues.jokeAppSecret,
            "page":0]

        AF.request("https://www.mxnzp.com/api/jokes/list",
                   method: .get,
                   parameters: jokeListParams).responseJSON { response in
            debugPrint(response)
            if let data = response.data {
                if let strData = String(data: data, encoding: .utf8) {
//                    print("strData: \(strData)")
                    let jokeListResponse = JSONDeserializer<JokeListResponse>.deserializeFrom(json: strData)
                    let dataResponse = jokeListResponse?.data
//                    print("dataResponse: \(dataResponse)")
                    let jokeList = dataResponse?.list
                    guard jokeList != nil else {
                        return
                    }
                    for jokeItem in jokeList! {
                        // TODO: weakSelf
//                        print("jokeItem: \(jokeItem.content)")
                        self.jokeList.append(jokeItem)
                    }
                    // TODO: weakSelf
                    self.jokeTableView.reloadData()
                }
            }
        }
    }

    func fetchEverydayOne() {
        let everydayWordParams: [String : Any] = [
            "app_id": ConstEncryptValues.everydayWordAppId,
            "app_secret": ConstEncryptValues.everydayWordAppSecret,
            "count":4]

        AF.request("https://www.mxnzp.com/api/daily_word/recommend",
                   method: .get,
                   parameters: everydayWordParams).responseJSON { response in
            debugPrint(response)
            if let data = response.data {
                if let strData = String(data: data, encoding: .utf8) {
                    let everydayOneResponse = JSONDeserializer<EverydayOneWordResponse>.deserializeFrom(json: strData)
                    let dataResponse = everydayOneResponse?.data
                    guard dataResponse != nil else {
                        return
                    }
                    print("data resp : \(dataResponse)")
                    self.everydayOneList = dataResponse!
                    self.everydayOneCollectionView.reloadData()
                }
            }
        }
    }
}
// MARK: - UITableView Protocol
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jokeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.cellReuseId, for: indexPath)
        let jokeItem = self.jokeList[indexPath.row]
        cell.textLabel?.text = jokeItem.content
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = ConstColor.mainColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPaht: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
}

// MARK: - UICollectionView Protocol
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.everydayOneList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EveryDayOneCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: EveryDayOneCollectionCell.cellReuseId, for: indexPath) as! EveryDayOneCollectionCell
        cell.backgroundColor = UIColor.red
        
        guard indexPath.row < everydayOneList.count else {
          return cell
        }
        var everydayOne = everydayOneList[indexPath.row]
        everydayOne.lunbo = "lunbo" + String(indexPath.row)
        cell.configCell(everydayOne: everydayOne)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstSize.screenWidth, height: HomeViewController.everyDayViewHeight)
    }
}
