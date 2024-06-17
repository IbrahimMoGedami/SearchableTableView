//
//  DropDownListViewController.swift
//  DropDownList
//
//  Created by Ibrahim Mo Gedami on 10/13/23.
//

import UIKit

class DropDownListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?
    
    private var viewModel: DropDownListViewModelProtocol
    var closure: ((Searchable?) -> ())?
    
    init(viewModel: DropDownListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        searchBar?.addAttributesToSearchBar(size: 13, color: UIColor.white)
        searchBar?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(cellType: DropDownTableViewCell.self)
        tableView?.setupTableViewDesign()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView?.reloadData()
    }
    
}

extension DropDownListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getDataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DropDownTableViewCell.self, for: indexPath)
        viewModel.setCell(cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.6) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
}

extension DropDownListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity: Searchable? = viewModel.didSelectCell(indexPath: indexPath)
        closure?(entity)
        dismiss(animated: true)
    }
    
}

extension DropDownListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchingText: searchText)
        tableView?.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarCancelButtonClicked()
        searchBar.text = ""
        tableView?.reloadData()
    }
    
}
