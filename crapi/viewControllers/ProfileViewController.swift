//
//  ProfileViewController.swift
//  crapi
//
//  Created by wayo on 26/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let service = Api()
    let endpoints = Endpoints()
    let playerTag = "8L9L9GL"
    
    var data: [ProfileCollectionViewModel] = []
      

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ProfileViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileViewCell")
        getPlayer(playerName: playerTag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func getPlayer(playerName:String) {
        let group = DispatchGroup()
        
        service.apiService(type: playerName, endPoint: endpoints.playerEndpoint){ (output) in
            
            group.enter() // wait// initialize
            
            let playerData = try? JSONDecoder().decode(Player.self, from: output!)
            print(playerData!.achievements)
            if (playerData != nil) {
                self.data = [ProfileCollectionViewModel(value: String(playerData!.trophies),title:"Trophies",image:UIImage(named: "img")!),
                             ProfileCollectionViewModel(value: String(playerData!.stats.maxTrophies),title: "Max Trophies",image:UIImage(named: "img")!),
                             ProfileCollectionViewModel(value: String(playerData!.games.wins),title: "Wins",image:UIImage(named: "img")!),
                             ProfileCollectionViewModel(value: "Mocking Spongebob",title: "majaron",image:UIImage(named: "img")!)]
                
                group.leave() // continue the loop

            }
            
            group.notify(queue: .main) {
                self.collectionView.reloadData()
                self.loadingSpinner.stopAnimating()
            }
            
        }
     
        
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
