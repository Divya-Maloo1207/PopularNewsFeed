import Foundation

class NYTimesPopularFeedResponseData: Decodable {
    let result: [NYTimesPopularFeedResultData]?

    private enum CodingKeys: String, CodingKey {
        case result = "results"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decodeIfPresent(
            Array<NYTimesPopularFeedResultData>.self,
            forKey: .result
        )
    }
}

class NYTimesPopularFeedResultData: Decodable {
    let title: String?
    let summary: String?
    let section: String?
    let feedURL: String?
    let media: [Media]?

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case summary = "abstract"
        case section = "section"
        case feedURL = "url"
        case media = "media"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        summary = try container.decodeIfPresent(String.self, forKey: .summary)
        feedURL = try container.decodeIfPresent(String.self, forKey: .feedURL)
        section = try container.decodeIfPresent(String.self, forKey: .section)
        media = try container.decodeIfPresent(Array<Media>.self, forKey: .media)
    }
}

class Media: Decodable {
    let mediaMetadata: MediaMetadata?

    private enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaMetadata = try container.decodeIfPresent(MediaMetadata.self, forKey: .mediaMetadata)
    }
}

class MediaMetadata: Decodable {
    let imageURL: String?
    let height: Int?
    let width: Int?

    private enum CodingKeys: String, CodingKey {
        case imageURL = "url"
        case height = "height"
        case width = "width"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
    }
}
