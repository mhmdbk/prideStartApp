//
//  BookMarksViewController.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 3/31/21.
//

import UIKit
import CoreData

class BookMarksViewController: UIViewController {
    
    @IBOutlet weak var bookmarksCollectionView: UICollectionView!
    
    var storiesList = [FavoriteStoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewInitialSetup()
    }
    
    func CollectionViewInitialSetup() {
        bookmarksCollectionView.delegate = self
        bookmarksCollectionView.dataSource = self
        bookmarksCollectionView.register(cellType: BookmarkCollectionViewCell.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        storiesList = [FavoriteStoryList]() 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Story")
         request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                 let storyTitle:String = data.value(forKey: "storyTitle") as! String
                let storyImageURL:String = data.value(forKey: "storyImageURL") as! String
                let storyPublishDate:String = data.value(forKey: "publishedDate") as! String
                let storyAbstract:String = data.value(forKey: "storyAbstract") as! String
                let storyURL:String = data.value(forKey: "storyURL") as! String

                let story = FavoriteStoryList(imageURL: storyImageURL, publishDate: storyPublishDate, title: storyTitle, abstract: storyAbstract, storyURL: storyURL)
                storiesList.append(story)
            }
            DispatchQueue.main.async {
                self.bookmarksCollectionView.reloadData()
            }
        } catch {
            print("Failed")
        }
    }
    
}

// MARK: - CollectionView Setup
extension BookMarksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: BookmarkCollectionViewCell.self, for: indexPath)
        let currentCell = storiesList[indexPath.row]
        cell.configure(withStoryList: currentCell)
        return cell
    }
}

extension BookMarksViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  

       /// 3
       func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let noOfCellsInRow = 1 // set how many number of cells per row u wish

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: size, height: size + 100)
       }
}
