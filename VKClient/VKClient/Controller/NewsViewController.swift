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
    
    @objc func refreshNews() {
        // Начинаем обновление новостей
        self.refreshControl?.beginRefreshing()
        // Определяем время самой свежей новости
        // или берем текущее время
        let mostFreshNewsDate = self.news.first?.date ?? Date().timeIntervalSince1970
        // отправляем сетевой запрос загрузки новостей
        self.vkApi.loadNewsData(startTime: mostFreshNewsDate + 1, token: Session.instance.token) { [weak self] (result, startFrom)  in
            switch result {
            case .success(let news):
                guard let self = self else { return }
                // выключаем вращающийся индикатор
                DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                }
                // проверяем, что более свежие новости действительно есть
                guard news.count > 0 else { return }
                // прикрепляем их в начало отображаемого массива
                self.news = news + self.news
                // формируем IndexSet свежедобавленных секций и обновляем таблицу
                //                let indexSet = IndexSet(integersIn: 0..<news.count)
                //                self.tableView.insertSections(indexSet, with: .automatic)
                self.tableView.reloadData()
            case .failure(_): break
            }
        }
    }


// MARK: - Variables And Properties
    // Инициализация класса VKApi.
    var vkApi = VKApi()
    //
    let realm = try! Realm()
    // Массив новостей.
    var news = [NewsItem]()
    // Параметр nextFrom.
    var nextFrom = ""
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self
        vkApi.loadNewsData(startTime: Date().timeIntervalSince1970, token: Session.instance.token) { _,_  in return }
        addNews()
        setupRefreshControl()
        
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
    
    // Функция настройки контроллера
    fileprivate func setupRefreshControl() {
        // Инициализируем и присваиваем сущность UIRefreshControl
        refreshControl = UIRefreshControl()
        // Настраиваем свойства контрола, как, например,
        // отображаемый им текст
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        // Цвет спиннера
        refreshControl?.tintColor = .red
        // Прикрепляется функция, которая будет вызываться контролом
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
                // Вычисляем высоту
                let tableWidth = tableView.bounds.width
                let news = self.news[indexPath.section]
                let cellHeight = tableWidth * news.photos.first!.aspectRatio
                return cellHeight
        default:
        // Для всех остальных ячеек оставляем автоматически определяемый размер
                return UITableView.automaticDimension
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

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Выбираем максимальный номер секции, которую нужно будет отобразить в ближайшее время
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        // Проверяем,является ли эта секция одной из трех ближайших к концу
        if maxSection > news.count - 3,
            // Убеждаемся, что мы уже не в процессе загрузки данных
            !isLoading {
            // Начинаем загрузку данных и меняем флаг isLoading
            isLoading = true
            // Cетевой сервис обрабатывает входящий параметр nextFrom и в качестве результата возвращет nextFrom для будущего запроса.
            vkApi.loadNewsData(startFrom: nextFrom, token: Session.instance.token) { [weak self] (result, nextFrom) in
                switch result {
                case .success(let news):
                    guard let self = self else { return }
                    // Прикрепляем новости к cуществующим новостям
                    let indexSet = IndexSet(integersIn: self.news.count ..< self.news.count + news.count)
                    self.news.append(contentsOf: news)
                    // Обновляем таблицу
                    self.tableView.insertSections(indexSet, with: .automatic)
                    // Выключаем статус isLoading
                    self.isLoading = false
                case .failure(_): break
                }
            }
        }
    }
}
