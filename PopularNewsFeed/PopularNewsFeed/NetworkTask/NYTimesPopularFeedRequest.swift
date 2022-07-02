import Foundation
class NYTimesPopularFeedResponse {
    let resultData: NYTimesPopularFeedResponseData?
    let error: Error?
    let isSuccessful: Bool

    init(
        resultData: NYTimesPopularFeedResponseData? = nil,
        error: Error? = nil,
        isSuccessful: Bool
    ) {
        self.resultData = resultData
        self.error = error
        self.isSuccessful = isSuccessful
    }
}

class NYTimesPopularFeedRequest {
    private let session = URLSession.shared
    private let request: URLRequest? = {
        guard let url = URL(
            string: NYTIMES_POPULAR_API_PATH + NYTIMES_POPULAR_API_KEY
        ) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 90.0

        return request
    }()

    func fetchPopularFeed(completion: @escaping(NYTimesPopularFeedResponse)-> ()) {
        guard let request = request else {
            completion(NYTimesPopularFeedResponse(isSuccessful: false))

            return
        }

        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(NYTimesPopularFeedResponse(error: error, isSuccessful: false))

                return
            }

            guard let data = data else {
                completion(NYTimesPopularFeedResponse(isSuccessful: false))

                return
            }

            do {
                let decoder = JSONDecoder()
                let resultData = try decoder.decode(NYTimesPopularFeedResponseData.self, from: data)

                completion(NYTimesPopularFeedResponse(resultData: resultData, isSuccessful: true))
            } catch {
                completion(NYTimesPopularFeedResponse(isSuccessful: false))
            }
        }

        dataTask.resume()
    }
}
