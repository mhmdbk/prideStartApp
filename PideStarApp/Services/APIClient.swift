//
//  ServicesClient.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 3/31/21.
//

import Foundation
import Moya

class APIClient : NSObject {

    static let shared = APIClient() //singelton pattern so no other class can initialize
    let provider = MoyaProvider<AppNetworkService>()
    
func getTopStories(withCompletionHandler completionHandler: @escaping (Result<TopStoriesHome,Error>) -> ()) {
    provider.request(.getTopStories) { result in
        switch result {
        case let .success(moyaResponnse):
            let topStories = try! JSONDecoder().decode(TopStoriesHome.self, from: moyaResponnse.data)
            completionHandler(.success(topStories))
            
        case .failure(let error):
            completionHandler(.failure(error))
        }
    }
    }
    
    
}
