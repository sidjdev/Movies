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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setDisplay() {
        crewName.text = crewData!.name
        guard let imageUrl = getImageUrl(imageSize: .medium, imageName: crewData!.profile_path ?? "") else { return }
        cellImage.sd_setImage(with: imageUrl, completed: nil)
        cellImage.makeCircular()
    }

    func getImageUrl(imageSize: imageSizeReference, imageName: String) -> URL? {
        var imageUrlString = Constants.URL.imageBaseUrl
        imageUrlString = imageUrlString+profile_sizes[imageSize]!+imageName
        guard let imageUrl = URL(string: imageUrlString) else { return nil }
        return imageUrl
    }
}
