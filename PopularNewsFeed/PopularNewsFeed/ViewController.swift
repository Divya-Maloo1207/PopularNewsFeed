import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    var tableView = UITableView()
    let spinner = UIActivityIndicatorView(style: .large)
    private(set) var isFetched = false

    lazy var dataSource: NYTimesPopularFeedDataSource = {
        return NYTimesPopularFeedDataSource { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.isFetched = true

            DispatchQueue.main.async {
                strongSelf.spinner.stopAnimating()
                strongSelf.tableView.reloadData()
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newsFeedIdentifier")
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)

        setupActivityIndicator()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isFetched {
            spinner.startAnimating()
        }
    }

    func setupActivityIndicator() {
        view.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let source = tableView.dataSource as? NYTimesPopularFeedDataSource
        let urlString = source?.data?[indexPath.row].feedURL ?? ""

        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc  = WebViewController(url: url)
        present(vc, animated: true)
    }
}

