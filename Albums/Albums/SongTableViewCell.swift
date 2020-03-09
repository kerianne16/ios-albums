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
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: Properties
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }

    //MARK: Actions
    @IBAction func addSongButton(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = durationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
      weak var delegate: SongTableViewCellDelegate?

        func updateViews() {
            if let song = song {
                addButton.isHidden = true
                
                songTitleTextField.text = song.title
                durationTextField.text = song.duration
            }
        }
        
        override func prepareForReuse() {
            songTitleTextField.text = ""
            durationTextField.text = ""
            addButton.isHidden = false
        }
}

    
protocol SongTableViewCellDelegate: AnyObject {
        func addSong(with title: String, duration: String)
    }
