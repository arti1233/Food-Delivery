import Foundation
import Alamofire

protocol AlamofireProtocol {
    func getMenu(position: Int, completion: @escaping(Result<Menu, Error>) -> Void)
    func getBanner(completion: @escaping(Result<Banner, Error>) -> Void)
}

class AlamofireProvider: AlamofireProtocol {
    func getMenu(position: Int, completion: @escaping (Result<Menu, Error>) -> Void) {
        AF.request(Constants.menuUrl.appending("\(position)/.json"), method: .get).responseDecodable(of: Menu.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getBanner(completion: @escaping(Result<Banner, Error>) -> Void) {
        AF.request(Constants.bannerUrl, method: .get).responseDecodable(of: Banner.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
