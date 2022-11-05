

import Foundation
import Alamofire


protocol NetworkServiceProtocol{
    func getPhotos(start:Int?,limit:Int?,completion: @escaping (Result<[Photo]?,Error>)-> Void)
}
class NetworkService: NetworkServiceProtocol  {
    func getPhotos(start: Int?,limit:Int?,completion: @escaping (Result<[Photo]?,Error>)-> Void) {

        AF.request(URLs.urls(start: start, limit: limit),method: .get).validate().responseDecodable(of: [Photo].self) { (response) in

                      switch response.result {
                          case .success( _):

                           guard let data = response.value else { return }
                          print("network data..\(data.count)")
                          completion(.success(data))

                          case .failure(let error):

                              print(error)
                          completion(.failure(error))
                      }
                  }
        
        
    }
    
    
    
}
