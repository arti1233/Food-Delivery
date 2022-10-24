//
//  URLSessionService.swift
//  Delivery
//
//  Created by Artsiom Korenko on 24.10.22.
//

import Foundation
import Alamofire

protocol AlamofireProtocol {
    func getMenu(completion: @escaping(Result<[Menu], Error>) -> Void)
}

class AlamofireProvider: AlamofireProtocol {
    func getMenu(completion: @escaping (Result<[Menu], Error>) -> Void) {
        AF.request("https://burger-king-1q2w3e4r5t.firebaseio.com/menu/.json", method: .get).responseDecodable(of: [Menu].self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
