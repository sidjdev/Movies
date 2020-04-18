//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsView: UIViewController {

    var movieDetailsVM: MovieDetailsVM? = nil
    
    @IBOutlet weak var backDropImage: UIImageView!
    
    enum imageSizeReference {
        case small
        case medium
        case large
        case original
    }
    let backdrop_sizes:[imageSizeReference : String] = [
        .small : "w300",
        .medium : "w780",
        .large : "w1280",
        .original : "original"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieDetailsVM?.selectedMovie?.title
        setBackDropImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setBackDropImage() {
        let backdropUrl = getImageUrl(imageSize: .medium, imageName: movieDetailsVM?.selectedMovie?.backdrop_path ?? "")
        backDropImage.sd_setImage(with: backdropUrl, completed: nil)
    }
    
    func getImageUrl(imageSize: imageSizeReference, imageName: String) -> URL? {
        var imageUrlString = Constants.URL.imageBaseUrl
        imageUrlString = imageUrlString+backdrop_sizes[imageSize]!+imageName
        guard let imageUrl = URL(string: imageUrlString) else { return nil }
        return imageUrl
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
