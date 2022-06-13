protocol LatestMoviesServiceable {
    func getLatest() async -> Result<PageDTO<MovieDTO>, RequestError>
}

struct LatestMoviesService: HTTPClient, LatestMoviesServiceable {
    func getLatest() async -> Result<PageDTO<MovieDTO>, RequestError> {
        return await sendRequest(
            endpoint: MoviesEndpoint.latest,
            responseModel: PageDTO<MovieDTO>.self
        )
    }
}
