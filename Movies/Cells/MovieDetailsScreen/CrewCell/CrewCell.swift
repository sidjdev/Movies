//
//  CrewCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit
import SDWebImage

class CrewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var crewName: UILabel!
    private var _crewData: Crew? = nil
    var crewData: Crew? {
        get {
            return _crewData
        }
        set {
            _crewData = newValue
            setDisplay()
        }
    }
    
    private var _movieData: MovieModel? = nil
    var movieData: MovieModel? {
        get {
            return _movieData
        }
        set {
            _movieData = newValue
            setSimilarMovie()
        }
    }
    enum imageSizeReference {
        case small
        case medium
        case large
        case original
    }
    
    let profile_sizes:[imageSizeReference : String] = [
        .small : "w45",
        .medium : "w185",
        .large : "h632",
        .original : "original"
    ]
    
    enum posterImageSizeReference {
        case small
        case medium
        case large
        case original
    }
    let posterSizes: [posterImageSizeReference : String] = [.small : "w92", .medium : "w342", .large : "w500", .original : "original"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setDisplay() {
        crewName.text = crewData!.name
        cellImage.image = nil
        guard let imageUrl = getImageUrl(imageSize: .medium, imageName: crewData!.profile_path ?? "") else { return }
        if crewData!.profile_path != nil {
            cellImage.sd_setImage(with: imageUrl, completed: nil)
            cellImage.makeCircular()
        } else {
            cellImage.image = UIImage(systemName: "person.circle")
        }
        
    }

    private func setSimilarMovie() {
        crewName.text = movieData!.title
        guard let imageUrl = getPosterImageUrl(imageSize: .medium, imageName: movieData!.poster_path ?? "") else { return }
        if movieData!.poster_path != nil {
            cellImage.sd_setImage(with: imageUrl, completed: nil)
            cellImage.makeCircular()
        } else {
            cellImage.image = UIImage(systemName: "video.circle")
        }
        
    }
    func getImageUrl(imageSize: imageSizeReference, imageName: String) -> URL? {
        var imageUrlString = Constants.URL.imageBaseUrl
        imageUrlString = imageUrlString+profile_sizes[imageSize]!+imageName
        guard let imageUrl = URL(string: imageUrlString) else { return nil }
        return imageUrl
    }
    
    func getPosterImageUrl(imageSize: posterImageSizeReference, imageName: String) -> URL? {
        var imageUrlString = Constants.URL.imageBaseUrl
        imageUrlString = imageUrlString+posterSizes[imageSize]!+imageName
        guard let imageUrl = URL(string: imageUrlString) else { return nil }
        return imageUrl
    }
}
