//
//  RideCell.swift
//  Sride
//
//  Created by sulagna on 3/25/22.
//

import UIKit

class RideCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeFrameLabel: UILabel!
    @IBOutlet weak var accompanyLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var sharerequestofferLabel: UILabel!
    @IBOutlet weak var vaccinatedLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
