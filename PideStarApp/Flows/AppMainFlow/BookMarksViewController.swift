//
//  BookMarksViewController.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 3/31/21.
//

import UIKit
import CoreData

class BookMarksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      

    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
 
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Story")
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                       print(data.value(forKey: "storyTitle") as! String)
                  }
                    
                } catch {
                    
                    print("Failed")
                }
    }

}
