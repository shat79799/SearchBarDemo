//
//  MyViewController.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import UIKit
import SnapKit

class MyViewController: UIViewController, MyView {
    
    var presenter: MyPresenter?
    let searchBar: UISearchBar = {
        let s = UISearchBar()
        
        return s
    }()
    
    let tableView: UITableView = {
        let t = UITableView()
        t.keyboardDismissMode = .onDrag
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter = MyPresenter(view: self)
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getPhotos()
    }
    
    func setupView() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func updatePhotos() {
        tableView.reloadData()
    }
    
}

extension MyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchText = searchBar.text,
           searchText.count > 0 {
            return presenter?.filteredPhotos.count ?? 0
        } else {
            return presenter?.photos.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let searchText = searchBar.text,
           searchText.count > 0 {
            if let filtered = presenter?.filteredPhotos {
                cell.textLabel?.text = filtered[indexPath.row].title
            }
        } else {
            if let photos = presenter?.photos {
                cell.textLabel?.text = photos[indexPath.row].title
            }
        }
        
        return cell
    }
}

extension MyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchBar.endEditing(true)
        
        if let searchText = searchBar.text,
           searchText.count > 0 {
            if let filtered = presenter?.filteredPhotos {
                print(filtered[indexPath.row])
            }
        } else {
            if let photos = presenter?.photos {
                print(photos[indexPath.row])
            }
        }
    }
}

extension MyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            presenter?.searchTitle(title: nil)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter?.searchTitle(title: searchBar.text)
    }
}
