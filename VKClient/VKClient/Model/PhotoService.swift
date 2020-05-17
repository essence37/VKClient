//
//  PhotoService.swift
//  VKClient
//
//  Created by Пазин Даниил on 13.05.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import Foundation
import Alamofire

class PhotoService {
    // Время хранения кэша.
    private let cacheLifeTime: TimeInterval = 10 * 60
    // Имя папки хранения кэша.
    private static let pathName: String = {
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    // Метод getFilePath получает на вход URL изображения и возвращает на его основе путь к файлу для сохранения или загрузки.
    private func getFilePath(url: String) -> String? {
            guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
            let hashName = url.split(separator: "/").last ?? "default"
            return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
        }
    // Метод  saveImageToChache сохраняет изображение в файловой системе.
    private func saveImageToChache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
        let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    private func getImageFromChache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        images[url] = image
        return image
    }
    // Словарь с изображениями из файловой системы.
    private var images = [String: UIImage]()
    // Последовательная очередь.
    private let syncQueue = DispatchQueue(label: "photo.cache.queue")
    // Метод loadPhoto загружает фото из сети.
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
            AF.request(url).responseData(queue: syncQueue) { [weak self] response in
                guard
                    let data = response.data,
                    let image = UIImage(data: data) else { return }
                self?.images[url] = image
                self?.saveImageToChache(url: url, image: image)
                DispatchQueue.main.async {
                    self?.container.reloadRow(atIndexpath: indexPath)
                }
            }
        }
    // Метод photo предоставляет изображение по URL.
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromChache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

private class Table: DataReloadable {
        let table: UITableView
        init(table: UITableView) {
            self.table = table
        }
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }

private class Collection: DataReloadable {
    let collection: UICollectionView
    
    init(collection: UICollectionView) {
        self.collection = collection
    }
    
    func reloadRow(atIndexpath indexPath: IndexPath) {
        collection.reloadItems(at: [indexPath])
    }
}
