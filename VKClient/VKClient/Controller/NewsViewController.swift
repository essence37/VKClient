//
//  NewsViewController.swift
//  VKClient
//
//  Created by Пазин Даниил on 21.11.2019.
//  Copyright © 2019 Пазин Даниил. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsViewController: UITableViewController {

// MARK: - Variables And Properties
    // Инициализация класса VKApi.
    var vkApi = VKApi()
    //
    let realm = try! Realm()
    // Массив новостей.
    var news = [NewsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vkApi.loadNewsData(token: Session.instance.token)
        addNews()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        
        let news: NewsItem = self.news[indexPath.row]
        cell.newsTextLabel.text = news.text
        cell.newsImageView.kf.setImage(with: URL(string: news.photos.first?.url ?? "Ooops"))

        return cell
    }

    // Добавление новостей в массив news.
    func addNews() {
        let allNews = self.realm.objects(NewsItem.self)
        for i in 0..<allNews.count {
            let news = allNews[i]
            self.news.append(news)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
