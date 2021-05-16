//
//  APIManager.swift
//  SearchBarDemo
//
//  Created by Stan Liu on 2021/5/16.
//

import Alamofire

typealias successCallback = ([Photo]) -> Void
typealias errorCallback = (AFError?) -> Void

class APIManager {
    static let shared = APIManager()
    
    private let urlString: String
    
    private init() {
        self.urlString = "https://jsonplaceholder.typicode.com/photos"
    }
    
    func getPhotosJSON(onSuccess successCallback: successCallback? = nil,
                       onError errorCallback: errorCallback? = nil) {
        AF.request(urlString,
                   method: .get)
            .responseJSON { response in
                if let responseData = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let items = try decoder.decode([Photo].self, from: responseData)
                        successCallback?(items)
                    } catch {
                        errorCallback?(nil)
                    }
                } else {
                    errorCallback?(response.error)
                }
            }
    }
}
