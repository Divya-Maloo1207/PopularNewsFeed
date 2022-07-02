import UIKit

class NYTimesPopularFeedDataSource: NSObject, UITableViewDataSource{
    private let request = NYTimesPopularFeedRequest()
    private(set) var data: [NYTimesPopularFeedResultData]?
    let fetchCompletion: () -> ()

    init(fetchCompletion: @escaping ()-> ()) {
        self.fetchCompletion = fetchCompletion
        super.init()

        request.fetchPopularFeed {[weak self] response in
            self?.data = response.resultData?.result
            self?.fetchCompletion()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "newsFeedIdentifier")
        cell.textLabel?.text = data?[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = data?[indexPath.row].summary
        cell.detailTextLabel?.numberOfLines = 0

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
}
