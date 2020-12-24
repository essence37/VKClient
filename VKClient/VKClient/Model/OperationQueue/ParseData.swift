//
//  ParseData.swift
//  VKClient
//
//  Created by Пазин Даниил on 07.05.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit
import SwiftyJSON

class ParseData: Operation {
    var outputData: [GroupItem] = []
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data else { return }
        let json = try! JSON(data: data)
        let groups = json["response"]["items"].arrayValue.map(GroupItem.init)
       
        outputData = groups
    }
}
