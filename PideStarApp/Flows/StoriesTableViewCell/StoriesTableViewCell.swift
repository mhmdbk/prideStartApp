//
//  StoriesTableViewCell.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 4/1/21.
//

import UIKit
import SDWebImage
import SkeletonView

class StoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var urlTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
        self.showAnimatedGradientSkeleton()
    }
    
    // MARK: - Configurable
    func configure(withStoryListResult storylistResult:Results) {
        
        //everything that is UI Related should be called in mainthread
        DispatchQueue.main.async {
            self.storyImageView.sd_setImage(with: URL(string: storylistResult.multimedia?.first?.url ?? ""), placeholderImage: UIImage(named: "noImageFound"))
            self.titleLabel.text = "Title: \(storylistResult.title ?? "")"
            self.dateTimeLabel.text = "Published Date: \(storylistResult.published_date ?? "")"
            self.abstractLabel.text = "abstract: \(storylistResult.abstract ?? "")"
            self.urlTextView.text = "URL: \(storylistResult.url ?? "")"
            
        }
    } 
    
}

// MARK: - Private helper methods
private extension StoriesTableViewCell {
    //some simple styling for each label
    func configureViews() {
        titleLabel.applyStyle(textColor: .black, font: Fonts.font(name: .font100, size: 15))
        dateTimeLabel.applyStyle(textColor: .brown, font: Fonts.font(name: .font100, size: 15))
        abstractLabel.applyStyle(textColor: .red, font: Fonts.font(name: .font100, size: 15))
    }
}

