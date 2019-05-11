//
//  Start.swift
//  GroceryClerk
//
//  Created by Tech on 2018-03-22.
//  Copyright © 2018 Apress. All rights reserved.
//

import Foundation
import SpriteKit



class StartScene: SKScene{
    
     let backgroundNode = SKSpriteNode(imageNamed: "background")
     let startButtonNode = SKSpriteNode(imageNamed: "PlayButton")
     let title = SKLabelNode(fontNamed: "Copperplate")
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundNode.size.width = frame.size.width;
        backgroundNode.anchorPoint = CGPoint(x:0.5, y:0.0);
        backgroundNode.color = SKColor.darkGray;
        backgroundNode.scale(to: CGSize(width: frame.width, height: frame.height))
        backgroundNode.position = CGPoint(x:size.width / 2, y:0);
        
        startButtonNode.size.width = frame.size.width;
        startButtonNode.anchorPoint = CGPoint(x:0.5, y:0.0);
        startButtonNode.scale(to: CGSize(width: frame.width/4, height: frame.height/8))
        startButtonNode.position = CGPoint(x:size.width / 2, y:0);
    
        
        title.position = CGPoint(x:size.width / 2, y:size.height / 2);
        title.text = "Grocery Clerk"
        title.fontColor = SKColor.black
        title.fontSize = 55
        
        addChild(backgroundNode);
        addChild(startButtonNode);
        addChild(title);
        
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first{
            let touchLocation = touch.location(in:self)
            let touchedWhere = nodes(at:touchLocation)
            
            if !touchedWhere.isEmpty{
                for node in touchedWhere{
                    if let sprite = node as? SKSpriteNode{
                        if sprite == startButtonNode{
                            let fadeTransition:SKTransition = SKTransition.fade(withDuration: (1))
                            let nextScene:SKScene = GameScene(size:self.size)
                            self.view?.presentScene(nextScene, transition:fadeTransition);                         
                            
                        }
                    }
                }
            }
        }
        
    }
  
    
}
