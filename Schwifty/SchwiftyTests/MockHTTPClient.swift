import Foundation

@testable import Schwifty

private extension Endpoint {
    var baseURL: String {
        return "https://mock.com"
    }
}

//class MockHTTPClient<T>: HTTPClient {
//
//    let response: Result<T, RequestError>
//
//    init(response: Result<T, RequestError>) {
//        self.response = response
//    }
//
//    func sendRequest<T>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> where T : Decodable {
//        return self.response
//    }
//}

/// A network client class you can inject to make your JSON networking code easily testable.
///
/// Just assign your expected JSON response or RequestError to the API endpoint path you want it returned to in the `responses` dictionary.
/// When your code makes network calls, the given response will be decoded and returned.
class MockJSONClient: HTTPClient {
    /// A lookup dictionary to assign expected JSON responses to endpoints
    var responses: [String : Result<Data, RequestError>] = [:]
    
    func sendRequest<T>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> where T : Decodable {
        var path = endpoint.path
        
        while path.hasPrefix("/") {
            path.removeFirst()
        }
        
        guard let request = buildRequest(endpoint: endpoint, path: path) else {
            return .failure(.invalidURL)
        }
        
        // fetch json response or error for specified path
        guard let expectedResponse = request.url.flatMap({ responses[$0.path] }) else {
            return .failure(.invalidURL)
        }
        
        // decode the request or return expected error
        switch expectedResponse {
        case let .success(data):
//            res["url"] = Result<String, Error> { return "" }
            
            guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                return .failure(.decode)
            }
            return .success(decodedResponse)
            
        case let .failure(error):
            return .failure(error)
        }
    }
}
