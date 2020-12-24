//
//  GetDataOperation1.swift
//  VKClient
//
//  Created by Пазин Даниил on 27.04.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import Alamofire

class GetDataOperation: AsyncOperation {
    
    // Отмена запроса и установка state в состояние выполнено (finished).
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    // Запрос.
    private var request: DataRequest
    // Хранилище для помещения полученных из интеренета данных.
    var data: Data?
    // Переопределённый метод main выполняет запрос в интернет, сохраняет данные в свойство data и устанавливает состояние операции finished.
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init (request: DataRequest) {
        self.request = request
    }
}
