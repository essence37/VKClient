//
//  GetDataOperation.swift
//  VKClient
//
//  Created by Пазин Даниил on 27.04.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import Alamofire

// Операция загрузки данных из интернета.
class AsyncOperation: Operation {
    // Свойство состояний, возвращающее стандартные флаги.
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    // Переменная, с установленным по умолчанию свойством.
    var state = State.ready {
        // Уведомление о том, что свойство собирается измениться.
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        // Уведомление о том, что свойство операции изменилось.
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    // Переопределение свойства, чтобы операция стала асинхронной.
    override var isAsynchronous: Bool {
        return true
    }
    // Учёт редопределённого свойства isReady, и состояния операции, которое устанавливает ему очередь и значение.
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    // Флаги состояния проверяют свойство state и возвращают результат.
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .finished
    }
    // Проверка, не была ли отменена операция еще до начала выполнения.
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    // Метод cancel вызывает реализацию метода из родительского класса, отменяет запрос и устанавливает state в состояние выполнено (finished).
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
