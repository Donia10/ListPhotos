

import Foundation
import Alamofire


protocol NetworkServiceProtocol{
    func getPhotos(start:Int?,limit:Int?,completion: @escaping (Result<[Photo]?,Error>)-> Void)
}
class NetworkService: NetworkServiceProtocol  {
    private lazy var session: URLSession = {
        URLCache.shared.memoryCapacity = 512 * 1024 * 1024
        // Create URL Session Configuration
        let configuration = URLSessionConfiguration.default
        
        // Define Request Cache Policy
        configuration.requestCachePolicy =  .useProtocolCachePolicy //.reloadRevalidatingCacheData//.useProtocolCachePolicy
        return URLSession(configuration: configuration)
    }()
    
    func getPhotos(start: Int?,limit:Int?,completion: @escaping (Result<[Photo]?,Error>)-> Void) {
        guard let url = URL(string: URLs.urls(start: start, limit: limit) ) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let datatask =  session.dataTask(with: request){[weak self] (data , response , error) in
            self?.session.configuration.urlCache?.cachedResponse(for: request)

        }
        datatask.resume()
        
        session.configuration.urlCache?.getCachedResponse(for: datatask, completionHandler: {
            cachedData in
            do{
                guard let data = cachedData?.data else {return}
                let decoder = JSONDecoder()
                
                let decodedData = try decoder.decode([Photo].self, from: data)
                print("cache data $\(decodedData.count)")
                
                DispatchQueue.main.async{
                    completion(.success(decodedData))
                }
            }catch{
                print("catch data ")
            }
            
        })
        
        
        
//        AF.request(URLs.urls(start: start, limit: limit),method: .get).validate().responseDecodable(of: [Photo].self) { (response) in
//
//                      switch response.result {
//                          case .success( _):
//
//                           guard let data = response.value else { return }
//                          print("network data..\(data.count)")
//                          completion(.success(data))
//
//                          case .failure(let error):
//
//                          print(error)
//                          completion(.failure(error))
//                      }
//
//        }

    }
    
    
  
}
