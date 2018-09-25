//
//  ViewController.swift
//  crapi
//
//  Created by wayo on 24/09/2018.
//  Copyright © 2018 juanjosecarracedo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let service = Api()
    let endpoints = Endpoints()
    let playerTag = "8L9L9GL"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        
    }
    
    func getPlayer(playerName:String) {
        service.apiService(type: playerName, endPoint: endpoints.playerEndpoint){ (output) in
            let playerData = try? JSONDecoder().decode(Player.self, from: output!)
            //print(playerData!.achievements)
            for i in playerData!.achievements {
                print(i.name)
            }
        }
        
    }
    
    func getPlayerAchivements(){
        service.apiService(type: playerTag, endPoint: endpoints.playerEndpoint){ (output) in
            let playerData = try? JSONDecoder().decode(Player.self, from: output!)
            //for i in playerData!.achievements {
              //  print(i.name)
            //}
        }
    }
    
    


}

