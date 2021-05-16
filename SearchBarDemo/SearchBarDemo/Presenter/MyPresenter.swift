//
//  MyPresenter.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import Foundation

protocol MyView {
    func updatePhotos(photos: [Photo])
}

protocol MyViewPresenter {
    init(view: MyView)
    func getPhotos()
}

class MyPresenter: MyViewPresenter {
    private let view: MyView
    private(set) var photos: [Photo]
    
    required init(view: MyView) {
        self.view = view
        self.photos = []
    }
    
    func getPhotos() {
        APIManager.shared.getPhotosJSON { photos in
            self.updatePhotos(photos: photos)
        } onError: { error in
            self.updatePhotos(photos: [])
            guard let error = error else {
                //parse failed
                print("parse data failed")
                return
            }
            print("network error: \(error)")
        }
    }
    
    private func updatePhotos(photos: [Photo]) {
        self.photos = photos
        self.view.updatePhotos(photos: photos)
    }
}
