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

    func updatePhotos(photos: [Photo]) {
        tableView.reloadData()
    }
    
}

extension MyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let photos = presenter?.photos {
            cell.textLabel?.text = photos[indexPath.row].title
        }
        
        return cell
    }
}

extension MyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let photos = presenter?.photos {
            print(photos[indexPath.row])
        }
    }
}

extension MyViewController: UISearchBarDelegate {
    
}
