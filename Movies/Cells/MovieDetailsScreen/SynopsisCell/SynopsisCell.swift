//
//  SynopsisCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit

class SynopsisCell: UITableViewCell {

    @IBOutlet weak var synopsisLabel: UILabel!
    
    private var _synopsis = ""
    
    var synopsis: String {
        get {
            return _synopsis
        }
        set {
            _synopsis = newValue
            setSynopsis()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        synopsisLabel.text = _synopsis
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSynopsis() {
        synopsisLabel.text = synopsis
    }
    
}
