//
//  ReviewsView.swift
//  Movies
//
//  Created by Sidharth J Dev on 19/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit

class ReviewsView: UIViewController {

    @IBOutlet weak var resultsTable: UITableView!
    let reviewsVM = MovieReviewsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reviewCellNib = UINib(nibName: "ReviewCell", bundle: nil)
        resultsTable.register(reviewCellNib, forCellReuseIdentifier: "reviewCell")
        resultsTable.rowHeight = UITableView.automaticDimension
        resultsTable.backgroundColor = .clear
        resultsTable.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
}

extension ReviewsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return reviewsVM.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsVM.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as? ReviewCell else { return UITableViewCell() }
        guard let reviewData = reviewsVM.cellData(at: indexPath) as? Review else { return UITableViewCell() }
        reviewCell.row = indexPath.row
        reviewCell.expansionRow = reviewsVM.expansionRow
        reviewCell.review = reviewData
        return reviewCell
    }
}

extension ReviewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        reviewsVM.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if reviewsVM.expansionRow == indexPath.row {
            reviewsVM.expansionRow = -1
        } else {
            reviewsVM.expansionRow = indexPath.row
        }
        DispatchQueue.main.async {
            self.resultsTable.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
