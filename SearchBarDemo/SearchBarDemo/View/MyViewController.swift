//
//  MyViewController.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import UIKit
import SnapKit
import Kingfisher

class MyViewController: UIViewController, MyView {
    
    var presenter: MyPresenter?
    let searchBar: UISearchBar = {
        let s = UISearchBar()
        
        return s
    }()
    
    let tableView: UITableView = {
        let t = UITableView()
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 200
        t.keyboardDismissMode = .onDrag
        t.register(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        if let searchText = searchBar.text,
           searchText.count > 0 {
            if let filtered = presenter?.filteredPhotos {
                let target = filtered[indexPath.row]
                cell.titleLb.text = target.title
                cell.imgView.kf.indicatorType = .activity
                cell.imgView.kf.setImage(with: URL(string: target.thumbnailUrl))
            }
        } else {
            if let photos = presenter?.photos {
                let target = photos[indexPath.row]
                cell.titleLb.text = target.title
                cell.imgView.kf.indicatorType = .activity
                cell.imgView.kf.setImage(with: URL(string: target.thumbnailUrl))
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
