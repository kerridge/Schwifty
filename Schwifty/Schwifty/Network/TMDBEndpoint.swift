protocol TMDBEndpoint: Endpoint { }

extension TMDBEndpoint {
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
}
