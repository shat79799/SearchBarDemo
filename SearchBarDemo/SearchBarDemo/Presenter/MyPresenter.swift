//
//  MyPresenter.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import Foundation

protocol MyView {
    
}

protocol MyViewPresenter {
    init(view: MyView)
    func getPhotos()
}

class MyPresenter: MyViewPresenter {
    let view: MyView
    
    required init(view: MyView) {
        self.view = view
    }
    
    func getPhotos() {
        APIManager.shared.getPhotosJSON { photos in
            print("total: \(photos.count), test: \(photos[0])")
        } onError: { error in
            guard let error = error else {
                //parse failed
                print("parse data failed")
                return
            }
            print("network error: \(error)")
        }

    }
}
