//
//  ViewController.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import UIKit


protocol IMainView : class {
    
    var presenter: IMainPresenter? { get set }
    
    func showPlaces(_ list: [Place])
    
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
}


class MainViewController : UIViewController {
    
    var presenter: IMainPresenter?
    
    private lazy var loadingView = LoadingView(view, backgroundColor: .secondarySystemBackground) {
        self.presenter?.update()
    }
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.register(UINib(nibName: "PlaceCell", bundle: nil), forCellReuseIdentifier: "PlaceCell")
        return tableView
    }()
    private var list: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter?.viewDidLoad()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
        
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func handleRefresh() {
        presenter?.update()
    }
}


extension MainViewController : IMainView {
    func showPlaces(_ list: [Place]) {
        self.list = list
        tableView.reloadData()
    }
    
    func showLoading() {
        loadingView.loading = true
    }
    
    func hideLoading() {
        loadingView.loading = false
        refreshControl.endRefreshing()
    }
    
    func showError(_ message: String) {
        loadingView.showError(message)
    }
}


extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        presenter.didSelect(at: indexPath.row)
    }
}


extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        cell.place = list[indexPath.row]
        return cell
    }
}
