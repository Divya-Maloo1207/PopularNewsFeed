import XCTest

@testable import PopularNewsFeed

class NYTimesPopularFeedResultDataTests: XCTestCase {
    private func readDataFromFile() -> Data? {
        let bundle = Bundle(for: NYTimesPopularFeedResultDataTests.self)
        guard let filePath = bundle.path(forResource: "SampleResponse", ofType: "json") else {
            XCTFail()
            return nil
        }

        XCTAssertNoThrow(try Data(contentsOf: URL(fileURLWithPath: filePath)))

        return try? Data(contentsOf: URL(fileURLWithPath: filePath))
    }

    func testAPIResultData() {
        guard let data = readDataFromFile() else {
            XCTFail()
            return
        }

        XCTAssertNoThrow(try JSONDecoder().decode(NYTimesPopularFeedResponseData.self, from: data))

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dataModel = try? decoder.decode(NYTimesPopularFeedResponseData.self, from: data)
        XCTAssertEqual(dataModel?.result?.count, 1)
        XCTAssertEqual(dataModel?.result?[0].media?.count, 1)
        XCTAssertEqual(dataModel?.result?[0].media?[0].mediaMetadata?.count, 3)
    }
}
