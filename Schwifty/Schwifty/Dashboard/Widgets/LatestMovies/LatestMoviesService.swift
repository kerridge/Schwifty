protocol LatestMoviesServiceable {
    func getLatest() async -> Result<LatestMovies, RequestError>
}

struct LatestMoviesService: HTTPClient, LatestMoviesServiceable {
    func getLatest() async -> Result<LatestMovies, RequestError> {
        return await sendRequest(
            endpoint: MoviesEndpoint.latest,
            responseModel: LatestMovies.self
        )
    }
}
