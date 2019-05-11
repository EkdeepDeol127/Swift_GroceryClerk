//
//  Food.swift
//  GroceryClerk
//
//  Created by C410 on 2018-04-02.
//  Copyright © 2018 Apress. All rights reserved.
//

import Foundation
import SpriteKit

enum foodType
{
    case FRUIT,
    VEGETABLE,
    DAIRY,
    MEAT,
    FISH,
    CANDY,
    EMPTY_NIL
};


class Food: SKSpriteNode
{
    var type: foodType
    {
        return foodType.EMPTY_NIL
    }
    
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

class Meat : Food
{
    override var type: foodType
    {
        return foodType.MEAT
    }
    
    convenience init()
    {
        self.init(texture: SKTexture(imageNamed: "Raddish"))
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Raddish")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Fish : Food
{
    override var type: foodType
    {
        return foodType.MEAT
    }
    
    convenience init()
    {
        self.init(texture: SKTexture(imageNamed: "Jello"))
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Jello")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}


class Fruit : Food
{
    override var type: foodType
    {
        return foodType.MEAT
    }
    
    convenience init()
    {
        self.init(texture: SKTexture(imageNamed: "Apple"))
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Apple")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Veggie : Food
{
    override var type: foodType
    {
        return foodType.MEAT
    }
    
    convenience init()
    {
        self.init(texture: SKTexture(imageNamed: "Carrot"))
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Carrot")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Candy : Food
{
    override var type: foodType
    {
        return foodType.CANDY
    }
    
    convenience init()
    {
        self.init(texture: SKTexture(imageNamed: "Candycane"))
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        self.texture = SKTexture(imageNamed: "Candycane")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

class Diary : Food
{
    override var type: foodType
    {
        return foodType.DAIRY
    }
    
    convenience init()
    {
        self.init(texture: SKTexture(imageNamed: "Cake"))
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)        
        self.texture = SKTexture(imageNamed: "Cake")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}




