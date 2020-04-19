//
//  ReviewCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 19/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var reviewContents: UILabel!
    
    private var _review: Review? = nil
    
    var review: Review? {
        set {
            _review = newValue
            setDisplay()
        }
        get {
            return _review
        }
    }
    var row = 0
    var expansionRow = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDisplay() {
        authorName.text = "By:-\(review!.author)"
        reviewContents.text = review!.content
        if row == expansionRow {
            reviewContents.numberOfLines = 0
        } else {
            reviewContents.numberOfLines = 3
        }
    }
    
}
