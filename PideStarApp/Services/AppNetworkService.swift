//
//  AppNetworkService.swift

import Foundation
import Moya


private let BASE_URL : String = "https://api.nytimes.com/svc/"
private let apikey = "bIi7mEAUBC0INm5PqIwilbUZWMzS9VyJ"

public enum AppNetworkService {
    case getTopStories 
}


extension AppNetworkService: TargetType {
    public var baseURL: URL {
        return URL(string: BASE_URL )!
    }
    
    public var path: String {
        switch self {
        case .getTopStories:
            return "topstories/v2/home.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTopStories:
            return .get
            
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getTopStories :
            return .requestParameters(parameters: ["api-key" : apikey ],
                                      encoding: URLEncoding.default)
            
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
 }
