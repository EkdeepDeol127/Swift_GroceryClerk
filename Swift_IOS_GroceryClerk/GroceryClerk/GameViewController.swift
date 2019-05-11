//
//  GameViewController.swift
//  GroceryClerk
//
//  Created by C412IT28 on 2018-03-19.
//  Copyright © 2018 Apress. All rights reserved.
//


import SpriteKit

class GameViewController: UIViewController {
    
    var sceneStart: StartScene!
    var sceneGame: GameScene!
    var sceneLose: LoseScene!
    var sceneWin: WinScene!
    
    
    override var prefersStatusBarHidden:Bool{
        return true;
    }
    
    public override func viewDidLoad(){
        
        super.viewDidLoad();
        let skView = view as! SKView;
        skView.showsFPS = true;
        sceneStart = StartScene(size:skView.bounds.size)
        sceneStart.scaleMode = .aspectFit;
        skView.presentScene(sceneStart);
        skView.showsPhysics = true 
    }
}
