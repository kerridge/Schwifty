protocol LatestMoviesServiceable {
    func getLatest() async -> Result<PageDTO<ListMovieDTO>, RequestError>
}

struct LatestMoviesService: HTTPClient, LatestMoviesServiceable {
    func getLatest() async -> Result<PageDTO<ListMovieDTO>, RequestError> {
        return await sendRequest(
            endpoint: MoviesEndpoint.latest,
            responseModel: PageDTO<ListMovieDTO>.self
        )
    }
}
