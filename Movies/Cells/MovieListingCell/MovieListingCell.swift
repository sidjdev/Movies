//
//  MovieListingCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListingCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var bookButton: UIButton!
    
    private var _cellData: MovieModel? = nil
    var cellData: MovieModel? {
        get {
            return _cellData
        }
        set {
            _cellData = newValue
            setContents()
        }
    }
    enum imageSizeReference {
        case small
        case medium
        case large
        case original
    }
    let backDropSizes: [imageSizeReference : String] = [.small : "w92", .medium : "w342", .large : "w500", .original : "original"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContents() {
        if cellData != nil {
            movieName.text = cellData!.title
            releaseDate.text = cellData!.release_date
            guard let imageURL = getImageUrl(for: cellData!, at: .small) else { return }
            imageView?.clipsToBounds = true
            imageView?.layer.masksToBounds = true
            imageView?.sd_setImage(with: imageURL, completed: nil)
            imageView?.layer.cornerRadius = 10.0
            
        }
    }
    
    
    private func getImageUrl(for cellData: MovieModel, at size: imageSizeReference) -> URL? {
        let imageName = cellData.poster_path.replacingOccurrences(of: "*/", with: "")
        let imageUrl = API.imageBaseUrl+backDropSizes[size]!+imageName
        
        if let url = URL(string: imageUrl) {
            return url
        }
        return nil
    }
}
