//
//  FeatureTableViewCell.swift
//  FeatureFlags_Example
//
//  Created by Tu Van on 05/10/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var featureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(_ content: String?) {
        self.featureLabel.text = content
    }
}
