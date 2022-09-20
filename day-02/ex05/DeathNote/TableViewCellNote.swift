//
//  TableViewCellNote.swift
//  DeathNote
//
//  Created by Anton Ivanov on 12.08.2022.
//

import UIKit

class TableViewCellNote: UITableViewCell {

	@IBOutlet weak var labelName: UILabel!
	@IBOutlet weak var labelDescription: UILabel!
	@IBOutlet weak var labelTimeOfLastVisit: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
