//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Keri Levesque on 3/9/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    
    //MARK: Outlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Actions
    @IBAction func addSongButton(_ sender: Any) {
    }
    
}
