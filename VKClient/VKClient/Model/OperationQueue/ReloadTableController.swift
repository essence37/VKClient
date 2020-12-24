//
//  ReloadTableController.swift
//  VKClient
//
//  Created by Пазин Даниил on 07.05.2020.
//  Copyright © 2020 Пазин Даниил. All rights reserved.
//

import UIKit

class ReloadTableController: Operation {
    var controller: AllGroupsController
    
    init(controller: AllGroupsController) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? ParseData else { return }
        controller.groups = parseData.outputData
        controller.filteredGroups = parseData.outputData
        controller.tableView.reloadData()
    }
}
