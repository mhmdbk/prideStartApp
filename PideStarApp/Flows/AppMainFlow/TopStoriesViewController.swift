//
//  TopStoriesViewController.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 3/31/21.
//

import UIKit
import SkeletonView
import CoreData

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
        storiesTableView.register(cellType: StoriesTableViewCell.self) //to avoid writing multiple line of codes for cellName eachtime u want to register tableview/collectionview and perhaps miss spilling it
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
        return 450
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorites = UIContextualAction(style: .normal, title: "Bookmark") {  (contextualAction, view, boolValue) in
            //Code I want to do here
            //to dismiss the bookmark after pressed, so no need to swap right again to dismiss it
            boolValue(true)
            
            //save the selected data in coredata to display in the bookmarksection
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Story", in: context)
            
            if let currentCell = self.storiesList?[indexPath.row] {
              
                //before adding to coredata, check if story is already bookmarked
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Story")
              
                let predicate = NSPredicate(format: "storyTitle = %@", "\(currentCell.title ?? "")")
                request.predicate = predicate
                request.fetchLimit = 1
                        do {
                            let count = try context.count(for: request)
                            
                            if count == 0 {
                                 //core data record not found, we can safely add it and no duplication of records will occur.
                                let newStory = NSManagedObject(entity: entity!, insertInto: context)
                                newStory.setValue(currentCell.title, forKey: "storyTitle")
                                newStory.setValue(currentCell.multimedia?.first?.url, forKey: "storyImageURL")
                                newStory.setValue(currentCell.abstract, forKey: "storyAbstract")
                                newStory.setValue(currentCell.published_date, forKey: "publishedDate")
                                newStory.setValue(currentCell.url, forKey: "storyURL") 
                                try context.save()
                                
                              }
                              else{
                                  print("coreData story record found")
                              }
                            
                        } catch {
                            print("Failed to save story coredata ")
                        }
               
            }
        }
        
        favorites.backgroundColor = UIColor.blue
        
        let swipeActions = UISwipeActionsConfiguration(actions: [favorites])
        
        return swipeActions
    }
    
}

extension TopStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //for better user experience,in case list not returned yet from server we will show animatedGradientSkeleton
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
