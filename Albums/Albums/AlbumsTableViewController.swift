//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Keri Levesque on 3/9/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
 
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           albumController.getAlbums { _ in
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }

    let albumController = AlbumController()
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            albumController.getAlbums { error in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            tableView.reloadData()
        }

    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         tableView.reloadData()
     }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumController.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        let album = albumController.albums[indexPath.row]
        
        cell.textLabel?.text = album.name
        cell.detailTextLabel?.text = album.artist

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier == "AddAlbumSegue" {
                  
                  guard let dVC = segue.destination as?
                      AlbumDetailTableViewController else { return }
                  
                  dVC.albumController = albumController
                  
              } else if segue.identifier == "DetailSegue" {
                  guard let dVC = segue.destination as?
                  AlbumDetailTableViewController,
                      let indexPath = tableView.indexPathForSelectedRow else { return }
                  
                  let album = albumController.albums[indexPath.row]
                  
                  dVC.album = album
                  dVC.albumController = albumController
              }
          }
    }
    

