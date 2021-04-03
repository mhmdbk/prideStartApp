//
//  BookmarkCollectionViewCell.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 4/3/21.
//

import UIKit

class BookmarkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var urlTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViews()
    }
    
    // MARK: - Configurable
    func configure(withStoryList storyList:FavoriteStoryList) {
        
        //everything that is UI Related should be called in mainthread
        DispatchQueue.main.async {
            self.storyImageView.sd_setImage(with: URL(string: storyList.imageURL ?? ""), placeholderImage: UIImage(named: "noImageFound"))
            self.titleLabel.text = "Title: \(storyList.title ?? "")"
            self.dateTimeLabel.text = "Published Date: \(storyList.publishDate ?? "")"
            self.abstractLabel.text = "abstract: \(storyList.abstract ?? "")"
            self.urlTextView.text = "URL: \(storyList.storyURL ?? "")"
            
        }
    }
    
}

// MARK: - Private helper methods
private extension BookmarkCollectionViewCell {
    //some simple styling for each label
    func configureViews() {
        titleLabel.applyStyle(textColor: .white, font: Fonts.font(name: .font100, size: 15))
        dateTimeLabel.applyStyle(textColor: .brown, font: Fonts.font(name: .font100, size: 15))
        abstractLabel.applyStyle(textColor: .red, font: Fonts.font(name: .font100, size: 15))
    }
}


