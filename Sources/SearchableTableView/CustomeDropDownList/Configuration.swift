//
//  Configuration.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import UIKit

public enum DropDownListConfiguration<DataModel: Displayable & Searchable> {
    
    case search([DataModel], (((any Searchable)?) -> ())?)
    
    public var viewController: UIViewController {
        switch self {
        case .search(let array, let completion):
            let viewModel = DropDownListViewModel(dataSource: array)
            let viewController = DropDownListViewController(viewModel: viewModel, closure: completion)
            return viewController
        }
    }
    
}
