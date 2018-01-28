//
//  MenuVC.swift
//  pong
//
//  Created by Brandon Klotz on 1/26/18.
//  Copyright © 2018 Brandon Klotz. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case twoPlayer
    case easy
    case medium
    case hard
}

class MenuVC: UIViewController {
    
    @IBAction func twoPlayer(_ sender: Any) {
        beginGame(game: .twoPlayer)
    }
    @IBAction func Easy(_ sender: Any) {
        beginGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        beginGame(game: .medium)
    }
    @IBAction func Hard(_ sender: Any) {
        beginGame(game: .hard)
    }
    
    func beginGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateInitialViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
