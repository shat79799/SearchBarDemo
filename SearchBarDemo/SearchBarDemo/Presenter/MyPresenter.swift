//
//  MyPresenter.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import Foundation

protocol MyView {
    func updatePhotos()
}

protocol MyViewPresenter {
    init(view: MyView)
    func getPhotos()
    func searchTitle(title: String?)
}

class MyPresenter: MyViewPresenter {
    private let view: MyView
    private(set) var photos: [Photo]
    private(set) var filteredPhotos: [Photo]
    
    required init(view: MyView) {
        self.view = view
        self.photos = []
        self.filteredPhotos = []
    }
    
    func getPhotos() {
        APIManager.shared.getPhotosJSON { photos in
            self.updatePhotos(photos: photos)
        } onError: { error in
            self.updatePhotos(photos: [])
            guard let error = error else {
                print("parse data failed")
                return
            }
            print("network error: \(error)")
        }
    }
    
    private func updatePhotos(photos: [Photo]) {
        self.photos = photos
        self.view.updatePhotos()
    }
    
    func searchTitle(title: String?) {
        guard let searchText = title else {
            filteredPhotos = []
            self.view.updatePhotos()
            return
        }
        let result = self.photos.filter({ $0.title.contains(searchText) })
        self.filteredPhotos = result
        self.view.updatePhotos()
    }
}
