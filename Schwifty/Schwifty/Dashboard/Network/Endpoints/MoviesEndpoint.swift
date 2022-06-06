enum MoviesEndpoint: Endpoint {
    case latest
    
    var path: String {
        switch self {
        case .latest:
            return "/"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var header: [String : String]? {
        // Access Token to use in Bearer header
        let accessToken = "Your TMDB Access Token here!!!!!!!"
        switch self {
        case .latest:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .latest:
            return nil
        }
    }
}

