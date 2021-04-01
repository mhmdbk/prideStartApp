//
//  TopStoriesViewController.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 3/31/21.
//

import UIKit
import SkeletonView

class TopStoriesViewController: UIViewController {
    
    var storiesList: [Results]?
    
    @IBOutlet weak var storiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetups()
        
        
    }
    
    func initialSetups() {
        tableViewInitialSetup()
        getTopStories()
    }
    
    func tableViewInitialSetup() {
        storiesTableView.delegate = self
        storiesTableView.dataSource = self
        storiesTableView.tableFooterView = UIView()
        storiesTableView.register(cellType: StoriesTableViewCell.self)
        self.storiesTableView.reloadData()
        
        
    }
    
    func getTopStories() {
        APIClient.shared.getTopStories { (result) in
            switch result {
            case .success:
                do {
                    self.storiesList = try result.get().results ?? []
                    self.storiesTableView.reloadData()
                } catch {}
            case .failure(let error):
                print("error\(error.localizedDescription)")
            }
        }
    }
}

extension TopStoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension TopStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //for better user experience,in case list not returned yet from server we will show animatedGradient
        return storiesList?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: StoriesTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let storiesList = self.storiesList {
            let currentCell = storiesList[indexPath.row]
            cell.configure(withStoryListResult: currentCell)
            //after list is returned from server, we can hide the skeleton animation
            cell.hideSkeleton()
        }
        
        return cell
    }
}

extension TopStoriesViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "StoriesTableViewCell"
    }
}
