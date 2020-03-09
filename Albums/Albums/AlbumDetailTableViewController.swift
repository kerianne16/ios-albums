//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Keri Levesque on 3/9/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController, SongTableViewCellDelegate {

    
    //MARK: Outlets
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverUrlTextField: UITextField!
    
    //MARK: Properties
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    var tempSongs: [Song] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
    
  
   func addSong(with title: String, duration: String) {
       guard let song = albumController?.createSong(with: title, duration: duration) else { return }
       
       tempSongs.append(song)
       tableView.reloadData()
       
       let indexPath = IndexPath(row: tempSongs.count, section: 0)
       tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
   }
   
   func updateViews() {
      
       guard let album = album, isViewLoaded else { return }
       
       title = album.name
       
       albumTextField.text = album.name
       artistTextField.text = album.artist
       genresTextField.text = album.genres.joined(separator: ", ")
       coverUrlTextField.text = album.coverArt.map({$0.absoluteString}).joined(separator: ", ")
       tempSongs = album.songs
   }

   // MARK: - Table view data source
   
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return indexPath.row == tempSongs.count ? 140 : 100
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tempSongs.count + 1
   }
   

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
       
       cell.delegate = self
       if indexPath.row < tempSongs.count {
           let song = tempSongs[indexPath.row]
           
           cell.song = song
       }

       // Configure the cell...
       return cell
   }

    //MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = albumTextField.text,
                  let artist = artistTextField.text,
                  let genre = genresTextField.text,
                  let coverURlsString = coverUrlTextField.text else { return }
              
              let genres = genre.components(separatedBy: ", ")
              let coverURLs = coverURlsString.components(separatedBy: ", ").compactMap({URL(string: $0) })
              
              if let album = album {
                  albumController?.update(album: album, with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
              } else {
                  albumController?.createAlbum(with: name, artist: artist, coverArtURLs: coverURLs, genres: genres, songs: tempSongs)
              }
              
              navigationController?.popViewController(animated: true)
    }
    
}
