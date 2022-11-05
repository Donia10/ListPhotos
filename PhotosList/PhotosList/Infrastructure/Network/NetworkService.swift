//import Foundation
//import Alamofire
//
//
//protocol NetworkServiceProtocol{
//    func getPhotos(offset:Int,completion: @escaping([Photo]?,Error?) -> () )
//}
//class NetworkService: NetworkServiceProtocol  {
//    func getPhotos(offset: Int, completion: @escaping ([Photo]?, Error?) -> ()) {
//    
//        AF.request(URLs.API_URL).validate().responseDecodable(of: [Photo].self) { (response) in
//
//                      switch response.result {
//                          case .success( _):
//
//                           guard let data = response.value else { return }
//                          print("network data..\(data.count)")
//                           completion(data, nil)
//
//                          case .failure(let error):
//
//                              print(error)
//                              completion(nil, error)
//                      }
//                  }
//        
//        
//    }
//    
//    
//    
//}
