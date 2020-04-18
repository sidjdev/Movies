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
    
    @IBOutlet weak var detailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieDetailsVM?.selectedMovie?.title
        setBackDropImage()
        let synopsisNib = UINib(nibName: "SynopsisCell", bundle: nil)
        let reviewsNib = UINib(nibName: "ReviewIndicatorCell", bundle: nil)
        detailsTable.register(synopsisNib, forCellReuseIdentifier: "synopsisCell")
        detailsTable.register(reviewsNib, forCellReuseIdentifier: "reviewIndicatorCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getSynopsis()
        getReviews()
        getCrew()
    }
    
    func getSynopsis() {
        movieDetailsVM?.getSynopsis(CompletionHandler: { (message, status) in
            DispatchQueue.main.async {
                self.detailsTable.reloadData()
            }
        })
    }
    
    func getReviews() {
        movieDetailsVM?.getReviews(CompletionHandler: { (message, status) in
            DispatchQueue.main.async {
                self.detailsTable.reloadData()
            }
        })
    }
    
    func getCrew() {
        movieDetailsVM?.getCrew(CompletionHandler: { (message, status) in
            DispatchQueue.main.async {
                self.detailsTable.reloadData()
            }
        })
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

extension MovieDetailsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Movies.details.numberOfSections(in: .details)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.details.numberOfRows(in: .details, In: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let synopsis = Movies.details.cellData(for: .details, at: indexPath) as? String else { return UITableViewCell() }
            guard let synopsisCell = tableView.dequeueReusableCell(withIdentifier: "synopsisCell") as? SynopsisCell else { return UITableViewCell() }
            synopsisCell.synopsis = synopsis
            return synopsisCell
            
        case 1:
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: "reviewIndicatorCell") as? ReviewIndicatorCell else { return UITableViewCell() }
            return reviewCell
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Movies.details.heightForRow(in: .details, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
