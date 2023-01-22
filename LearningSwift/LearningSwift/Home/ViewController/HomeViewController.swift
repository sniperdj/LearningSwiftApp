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
    
    lazy var jokeTableView: UITableView = {
        let jokeTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ConstSize.screenWidth, height: ConstSize.screenHeight), style: UITableView.Style.plain)
        jokeTableView.delegate = self
        jokeTableView.dataSource = self
        jokeTableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeViewController.cellReuseId)
        jokeTableView.tableFooterView = UIView()
        jokeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        jokeTableView.backgroundColor = UIColor.white
        return jokeTableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        title = "首页"
        view.addSubview(jokeTableView)

        // testInterface()
        fetchJokeList()
    }

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
//                print("data: \(data)")
                if let strData = String(data: data, encoding: .utf8) {
                    print("strData: \(strData)")
                    let jokeListResponse = JSONDeserializer<JokeListResponse>.deserializeFrom(json: strData)
                    print("jokeListResponse: \(jokeListResponse)")
                }
                // if let dictData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                //     print("dictData type: \(type(of: dictData))")
                //     if let dict = dictData as? [String: Any] {
                //         let isValidJSON = JSONSerialization.isValidJSONObject(dict)
                //         print("isValidJSON: \(isValidJSON)")
                //     }
                // }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.cellReuseId, for: indexPath)
        cell.textLabel?.text = "这是一个笑话"
        cell.textLabel?.textColor = ConstColor.mainColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
