//
//  ProfileViewController.swift
//  crapi
//
//  Created by wayo on 25/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let service = Api()
    let endpoints = Endpoints()
    let playerTag = "8L9L9GL"
    
    var playerStats = [String]()

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getPlayer(playerName: playerTag)
        self.collectionView.reloadSections(IndexSet(integer:0))
            
        
    }
    
    func getPlayer(playerName:String) {
        service.apiService(type: playerName, endPoint: endpoints.playerEndpoint){ (output) in
            let playerData = try? JSONDecoder().decode(Player.self, from: output!)
            //print(playerData!.achievements)
            
            self.playerStats.append(playerData!.name)
            self.playerStats.append(String(playerData!.trophies))
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerStats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let pS = playerStats[indexPath.row]
        
        cell.displayContent(image:UIImage(named: "img")! , title: pS, value: pS)
        
        return cell
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
