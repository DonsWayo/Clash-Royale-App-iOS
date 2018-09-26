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
    
    
    let data: [ProfileCollectionViewModel] =
        [ProfileCollectionViewModel(image: #imageLiteral(resourceName: "img"), title: "Mocking Spongebob", value: "Mocking Spongebob"),
         ProfileCollectionViewModel(image: #imageLiteral(resourceName: "img"), title: "Mocking Spongebob", value: "Mocking Spongebob"),
         ProfileCollectionViewModel(image: #imageLiteral(resourceName: "img"), title: "Mocking Spongebob", value: "Mocking Spongebob"),
         ProfileCollectionViewModel(image: #imageLiteral(resourceName: "img"), title: "Mocking Spongebob", value: "Mocking Spongebob")]

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib.init(nibName: "ProfileViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileViewCell")
            
        
    }
    
    func getPlayer(playerName:String) {
        service.apiService(type: playerName, endPoint: endpoints.playerEndpoint){ (output) in
            let playerData = try? JSONDecoder().decode(Player.self, from: output!)
            //print(playerData!.achievements)
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileViewCell", for: indexPath) as! CollectionViewCell
        cell.displayContent(with: data[indexPath.row])
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
