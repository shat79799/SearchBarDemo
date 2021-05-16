//
//  Photo.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
