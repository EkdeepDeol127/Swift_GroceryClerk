//
//  Baskets.swift
//  GroceryClerk
//
//  Created by Tech on 2018-04-09.
//  Copyright © 2018 Apress. All rights reserved.
//

import Foundation
import SpriteKit

class Basket: SKSpriteNode
{
    convenience init()
    {
        self.init()
        self.texture = SKTexture(imageNamed: "Spaceship")
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Spaceship")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
