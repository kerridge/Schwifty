protocol LatestMoviesService {
    func fetch() async throws -> [LatestMovie]
}
