//
//  GameScene.swift
//  GroceryClerk
//
//  Created by C412IT28 on 2018-03-19.
//  Copyright © 2018 Apress. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    // UI elements
    let backgroundNode = SKSpriteNode(imageNamed: "background")
    var score = 0
    var level = 0
    let scoreTextNode = SKLabelNode(fontNamed: "Copperplate")
    let startGameTextNode = SKLabelNode(fontNamed: "Copperplate")
    let levelTextNode = SKLabelNode(fontNamed: "Copperplate")
    let PausedTextNode = SKLabelNode(fontNamed: "Copperplate")
    let pauseButtonNode = SKSpriteNode(imageNamed: "PauseButton")
    let backButtonNode = SKSpriteNode(imageNamed: "BackButton")
    let redLineNode = SKSpriteNode(imageNamed: "redLine2")
    
    // Grocery Bags
    let fruitBagNode = SKSpriteNode(imageNamed: "GroceryBag")
    let meatBagNode = SKSpriteNode(imageNamed: "GroceryBag")
    let fishBagNode = SKSpriteNode(imageNamed: "GroceryBag")
    let veggieBagNode = SKSpriteNode(imageNamed: "GroceryBag")
    let candyBagNode = SKSpriteNode(imageNamed: "GroceryBag")
    let diaryBagNode = SKSpriteNode(imageNamed: "GroceryBag")
    
    // Grocery Bags Text
    let fruitBagText = SKLabelNode(fontNamed: "Copperplate")
    let meatBagText = SKLabelNode(fontNamed: "Copperplate")
    let fishBagText = SKLabelNode(fontNamed: "Copperplate")
    let veggieBagText = SKLabelNode(fontNamed: "Copperplate")
    let candyBagText = SKLabelNode(fontNamed: "Copperplate")
    let diaryBagText = SKLabelNode(fontNamed: "Copperplate")
    
    //obj holder
    var selectedNode: SKSpriteNode?
    
    // Obj Arrays
    var meatArray: [Meat?] = [];
    var meat: Meat?
    var fishArray: [Fish?] = [];
    var fish: Fish?
    var fruitArray: [Fruit?] = [];
    var fruit: Fruit?
    var veggieArray: [Veggie?] = [];
    var veggie: Veggie?
    var diaryArray: [Diary?] = [];
    var diary: Diary?
    var candyArray: [Candy?] = [];
    var candy: Candy?

    let CollisionCategoryFood : UInt32 = 0x1 << 1
    let CollisionCategoryRedLine: UInt32 = 0x1 << 2
    let CollisionCategoryBag: UInt32 = 0x1 << 3
    let CollisionCategoryNone: UInt32 = 0x1 << 4
    
    //other variables for spawning
    var timer:Float = 2.0;
    var randtype:Int?
    var randArray:Int?
    var randLocal:Int?
    var offScreen: CGPoint?;
    var temp: Int?;
    var spawnPointArray: [CGPoint?] = [];
    
    //MARK: - Booleans
    var nodeSelected = false
    var holdType: UInt32?;
    
    required init?(coder aDecoder:NSCoder)
    {
        super.init(coder:aDecoder);
    }
    
    override init(size:CGSize)
    {
        // * SETTING UP BACKGROUND AND UI
        super.init(size:size);
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.1)
        physicsWorld.contactDelegate = self
        
        backgroundNode.size.width = frame.size.width;
        backgroundNode.anchorPoint = CGPoint(x:0.5, y:0.0);
        backgroundNode.scale(to: CGSize(width: frame.width, height: frame.height))
        backgroundNode.position = CGPoint(x:size.width / 2, y:0);
        
        pauseButtonNode.size.width = frame.size.width;
        pauseButtonNode.anchorPoint = CGPoint(x:0.5, y:0.0);
        pauseButtonNode.scale(to: CGSize(width: frame.width/11, height: frame.height/21))
        pauseButtonNode.position = CGPoint(x: 25, y:size.height - 40);
        
        PausedTextNode.text = "Paused!"
        PausedTextNode.fontSize = 100
        PausedTextNode.fontColor = SKColor.black
        PausedTextNode.position = CGPoint(x: frame.width - 10, y: frame.height / 2)
        PausedTextNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        PausedTextNode.isHidden = true
        
        backButtonNode.size.width = frame.size.width;
        backButtonNode.anchorPoint = CGPoint(x:0.5, y:0.0);
        backButtonNode.scale(to: CGSize(width: frame.width/11, height: frame.height/21))
        backButtonNode.position = CGPoint(x: 25, y:size.height - 80);
        
        scoreTextNode.text = "SCORE : \(score)"
        scoreTextNode.fontSize = 25
        scoreTextNode.fontColor = SKColor.black
        scoreTextNode.position = CGPoint(x: size.width - 40, y: size.height - 40)
        scoreTextNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        levelTextNode.text = "LEVEL : \(level)"
        levelTextNode.fontSize = 25
        levelTextNode.fontColor = SKColor.black
        levelTextNode.position = CGPoint(x: 190, y: size.height - 40)
        levelTextNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        //Baskets
        meatBagNode.size.width = frame.size.width;
        meatBagNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        meatBagNode.scale(to: CGSize(width: frame.width / 8, height: frame.height / 10))
        meatBagNode.position = CGPoint(x: 30, y:size.height - 600);
        meatBagNode.physicsBody = SKPhysicsBody(rectangleOf: meatBagNode.size);
        meatBagNode.physicsBody?.affectedByGravity = false;
        meatBagNode.physicsBody?.isDynamic = false
        meatBagNode.physicsBody?.categoryBitMask = CollisionCategoryBag
        meatBagNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        meatBagNode.physicsBody?.collisionBitMask = 0
        meatBagNode.name = "MeatBasket"
        
        meatBagText.text = "Meat Bag"
        meatBagText.fontSize = 10
        meatBagText.fontColor = SKColor.black
        meatBagText.position = CGPoint(x: meatBagNode.position.x + 30, y: meatBagNode.position.y - 50)
        meatBagText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        fishBagNode.size.width = frame.size.width;
        fishBagNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        fishBagNode.scale(to: CGSize(width: frame.width / 8, height: frame.height / 10))
        fishBagNode.position = CGPoint(x: 100, y:size.height - 600);
        fishBagNode.physicsBody = SKPhysicsBody(rectangleOf: fishBagNode.size);
        fishBagNode.physicsBody?.affectedByGravity = false;
        fishBagNode.physicsBody?.isDynamic = false
        fishBagNode.physicsBody?.categoryBitMask = CollisionCategoryBag
        fishBagNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        fishBagNode.physicsBody?.collisionBitMask = 0
        fishBagNode.name = "FishBasket"
        
        fishBagText.text = "Fish Bag"
        fishBagText.fontSize = 10
        fishBagText.fontColor = SKColor.black
        fishBagText.position = CGPoint(x: fishBagNode.position.x + 30, y: fishBagNode.position.y - 50)
        fishBagText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        fruitBagNode.size.width = frame.size.width;
        fruitBagNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        fruitBagNode.scale(to: CGSize(width: frame.width / 8, height: frame.height / 10))
        fruitBagNode.position = CGPoint(x: 170, y:size.height - 600);
        fruitBagNode.physicsBody = SKPhysicsBody(rectangleOf: fruitBagNode.size);
        fruitBagNode.physicsBody?.affectedByGravity = false;
        fruitBagNode.physicsBody?.categoryBitMask = CollisionCategoryBag
        fruitBagNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        fruitBagNode.physicsBody?.isDynamic = false
        fruitBagNode.physicsBody?.collisionBitMask = 0
        fruitBagNode.name = "FruitBasket"
        
        fruitBagText.text = "Fruit Bag"
        fruitBagText.fontSize = 10
        fruitBagText.fontColor = SKColor.black
        fruitBagText.position = CGPoint(x: fruitBagNode.position.x + 30, y: fruitBagNode.position.y - 50)
        fruitBagText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        veggieBagNode.size.width = frame.size.width;
        veggieBagNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        veggieBagNode.scale(to: CGSize(width: frame.width / 8, height: frame.height / 10))
        veggieBagNode.position = CGPoint(x: 240, y:size.height - 600);
        veggieBagNode.physicsBody = SKPhysicsBody(rectangleOf: veggieBagNode.size);
        veggieBagNode.physicsBody?.affectedByGravity = false;
        veggieBagNode.physicsBody?.categoryBitMask = CollisionCategoryBag
        veggieBagNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        veggieBagNode.physicsBody?.isDynamic = false
        veggieBagNode.physicsBody?.collisionBitMask = 0
        veggieBagNode.name = "VeggieBasket"
        
        veggieBagText.text = "Veggie Bag"
        veggieBagText.fontSize = 10
        veggieBagText.fontColor = SKColor.black
        veggieBagText.position = CGPoint(x: veggieBagNode.position.x + 30, y: veggieBagNode.position.y - 50)
        veggieBagText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        diaryBagNode.size.width = frame.size.width;
        diaryBagNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        diaryBagNode.scale(to: CGSize(width: frame.width / 8, height: frame.height / 10))
        diaryBagNode.position = CGPoint(x: 310, y:size.height - 600);
        diaryBagNode.physicsBody = SKPhysicsBody(rectangleOf: diaryBagNode.size);
        diaryBagNode.physicsBody?.affectedByGravity = false;
        diaryBagNode.physicsBody?.isDynamic = false
        diaryBagNode.physicsBody?.categoryBitMask = CollisionCategoryBag
        diaryBagNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        diaryBagNode.physicsBody?.collisionBitMask = 0
        diaryBagNode.name = "DiaryBasket"
        
        diaryBagText.text = "Diary Bag"
        diaryBagText.fontSize = 10
        diaryBagText.fontColor = SKColor.black
        diaryBagText.position = CGPoint(x: diaryBagNode.position.x + 30, y: diaryBagNode.position.y - 50)
        diaryBagText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        candyBagNode.size.width = frame.size.width;
        candyBagNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        candyBagNode.scale(to: CGSize(width: frame.width / 8, height: frame.height / 10))
        candyBagNode.position = CGPoint(x: 380, y:size.height - 600);
        candyBagNode.physicsBody = SKPhysicsBody(rectangleOf: candyBagNode.size);
        candyBagNode.physicsBody?.affectedByGravity = false;
        candyBagNode.physicsBody?.isDynamic = false
        candyBagNode.physicsBody?.categoryBitMask = CollisionCategoryBag
        candyBagNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        candyBagNode.physicsBody?.collisionBitMask = 0
        candyBagNode.name = "CandyBasket"
        
        candyBagText.text = "Candy Bag"
        candyBagText.fontSize = 10
        candyBagText.fontColor = SKColor.black
        candyBagText.position = CGPoint(x: candyBagNode.position.x + 30, y: candyBagNode.position.y - 50)
        candyBagText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        
        //MARK: - RED LINE
        redLineNode.size.width = frame.size.width;
        redLineNode.anchorPoint = CGPoint(x:0.5, y:0.5);
        redLineNode.scale(to: CGSize(width: frame.width * 10, height: frame.height / 8))
        redLineNode.position = CGPoint(x: 0, y:size.height - 700);
        redLineNode.physicsBody = SKPhysicsBody(texture: redLineNode.texture!, size: CGSize(width: redLineNode.size.width, height: redLineNode.size.height));
        redLineNode.physicsBody?.pinned = true
        redLineNode.physicsBody?.affectedByGravity = false;
        redLineNode.physicsBody?.isDynamic = false
        redLineNode.physicsBody?.categoryBitMask = CollisionCategoryRedLine
        redLineNode.physicsBody?.contactTestBitMask = CollisionCategoryFood
        redLineNode.physicsBody?.collisionBitMask = 0
        redLineNode.name = "RedLine"
        
        
        // * ADDING ALL SCENE/UI ELEMENTS
        addChild(backgroundNode);
        addChild(pauseButtonNode);
        addChild(PausedTextNode);
        addChild(backButtonNode);
        addChild(levelTextNode);
        addChild(scoreTextNode);
        addChild(redLineNode);
        //bags
        addChild(fruitBagNode);
        addChild(fishBagNode);
        addChild(meatBagNode);
        addChild(veggieBagNode);
        addChild(candyBagNode);
        addChild(diaryBagNode);
        //bags texts
        addChild(fruitBagText);
        addChild(fishBagText);
        addChild(meatBagText);
        addChild(veggieBagText);
        addChild(candyBagText);
        addChild(diaryBagText);
        
        offScreen = CGPoint(x: frame.width / 2, y: frame.height + 100);
        
        for index in 0...5
        {
            let point = CGPoint(x: (CGFloat)(60 * index) + 80, y: frame.height + 30)
            spawnPointArray.append(point)
        }
        
        for index in 0...20
        {
            meat = Meat().copy() as? Meat
            meatArray.append(meat)
            meatArray[index]?.position = (offScreen)!;
            meatArray[index]?.scale(to: CGSize(width: (meatArray[index]?.size.width)! / 2.0, height: (meatArray[index]?.size.height)! / 2.0))
            meatArray[index]?.physicsBody = SKPhysicsBody(circleOfRadius: (meatArray[index]?.size.width)! / 2.0);
            meatArray[index]?.physicsBody?.isDynamic = true;
            meatArray[index]?.physicsBody?.affectedByGravity = false;
            meatArray[index]?.physicsBody?.categoryBitMask = CollisionCategoryFood
            meatArray[index]?.physicsBody?.collisionBitMask = 0
            meatArray[index]?.name = "Meat"
            addChild(meatArray[index]!)
            
            fish = Fish().copy() as? Fish
            fishArray.append(fish)
            fishArray[index]?.position = (offScreen)!;
            fishArray[index]?.scale(to: CGSize(width: (fishArray[index]?.size.width)! / 2.0, height: (fishArray[index]?.size.height)! / 2.0))
            fishArray[index]?.physicsBody = SKPhysicsBody(circleOfRadius: (fishArray[index]?.size.width)! / 2.0);
            fishArray[index]?.physicsBody?.isDynamic = true;
            fishArray[index]?.physicsBody?.affectedByGravity = false;
            fishArray[index]?.physicsBody?.categoryBitMask = CollisionCategoryFood
            fishArray[index]?.physicsBody?.collisionBitMask = 0
            fishArray[index]?.name = "Fish"
            addChild(fishArray[index]!)
            
            fruit = Fruit().copy() as? Fruit
            fruitArray.append(fruit)
            fruitArray[index]?.position = (offScreen)!;
            fruitArray[index]?.scale(to: CGSize(width: (fruitArray[index]?.size.width)! / 2.0, height: (fruitArray[index]?.size.height)! / 2.0))
            fruitArray[index]?.physicsBody = SKPhysicsBody(circleOfRadius: (fruitArray[index]?.size.width)! / 2.0);
            fruitArray[index]?.physicsBody?.isDynamic = true;
            fruitArray[index]?.physicsBody?.affectedByGravity = false;
            fruitArray[index]?.physicsBody?.categoryBitMask = CollisionCategoryFood
            fruitArray[index]?.physicsBody?.collisionBitMask = 0
            fruitArray[index]?.name = "Fruit"
            addChild(fruitArray[index]!)
            
            veggie = Veggie().copy() as? Veggie
            veggieArray.append(veggie)
            veggieArray[index]?.position = (offScreen)!;
            veggieArray[index]?.scale(to: CGSize(width: (veggieArray[index]?.size.width)! / 2.0, height: (veggieArray[index]?.size.height)! / 2.0))
            veggieArray[index]?.physicsBody = SKPhysicsBody(circleOfRadius: (veggieArray[index]?.size.width)! / 2.0);
            veggieArray[index]?.physicsBody?.isDynamic = true;
            veggieArray[index]?.physicsBody?.affectedByGravity = false;
            veggieArray[index]?.physicsBody?.categoryBitMask = CollisionCategoryFood
            veggieArray[index]?.physicsBody?.collisionBitMask = 0
            veggieArray[index]?.name = "Veggie"
            addChild(veggieArray[index]!)
            
            diary = Diary().copy() as? Diary
            diaryArray.append(diary)
            diaryArray[index]?.position = (offScreen)!;
            diaryArray[index]?.scale(to: CGSize(width: (diaryArray[index]?.size.width)! / 2.0, height: (diaryArray[index]?.size.height)! / 2.0))
            diaryArray[index]?.physicsBody = SKPhysicsBody(circleOfRadius: (diaryArray[index]?.size.width)! / 2.0);
            diaryArray[index]?.physicsBody?.isDynamic = true;
            diaryArray[index]?.physicsBody?.affectedByGravity = false;
            diaryArray[index]?.physicsBody?.categoryBitMask = CollisionCategoryFood
            diaryArray[index]?.physicsBody?.collisionBitMask = 0
            diaryArray[index]?.name = "Diary"
            addChild(diaryArray[index]!)
            
            candy = Candy().copy() as? Candy
            candyArray.append(candy)
            candyArray[index]?.position = (offScreen)!;
            candyArray[index]?.scale(to: CGSize(width: (candyArray[index]?.size.width)! / 2.0, height: (candyArray[index]?.size.height)! / 2.0))
            candyArray[index]?.physicsBody = SKPhysicsBody(circleOfRadius: (candyArray[index]?.size.width)! / 2.0);
            candyArray[index]?.physicsBody?.isDynamic = true;
            candyArray[index]?.physicsBody?.affectedByGravity = false;
            candyArray[index]?.physicsBody?.categoryBitMask = CollisionCategoryFood
            candyArray[index]?.physicsBody?.collisionBitMask = 0
            candyArray[index]?.name = "Candy"
            addChild(candyArray[index]!)
        }
    }

    override func update(_ currentTime: TimeInterval)
    {
        rePosition();
        if(timer <= 0)
        {
            timer = 2.0;
            randtype = Int(arc4random_uniform(6))
            randArray = Int(arc4random_uniform(20))
            randLocal = Int(arc4random_uniform(6))
            Spawned();
        }
        else
        {
            timer -= 0.1;
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        if let touch = touches.first
        {
            let touchLocation = touch.location(in:self)
            let touchedWhere = nodes(at:touchLocation)
            
            if !touchedWhere.isEmpty
            {
                for node in touchedWhere
                {
                    if let sprite = node as? SKSpriteNode
                    {
                        if sprite == pauseButtonNode
                        {
                            if(isPaused == false)
                            {
                                isPaused = true
                                PausedTextNode.isHidden = false;
                            }
                            else
                            {
                                isPaused = false
                                PausedTextNode.isHidden = true;
                            }
                        }
                        if sprite == backButtonNode
                        {
                            let fadeTransition:SKTransition = SKTransition.fade(withDuration: (1))
                            let nextScene:SKScene = StartScene(size:self.size)
                            self.view?.presentScene(nextScene, transition:fadeTransition);
                        }
                        
                        if(node.name == "Meat" || node.name == "Fish" || node.name == "Fruit" || node.name == "Veggie" || node.name == "Diary" || node.name == "Candy")
                        {
                            nodeSelected = true
                            holdType = node.physicsBody?.categoryBitMask
                            node.physicsBody?.categoryBitMask = CollisionCategoryNone
                            node.physicsBody?.affectedByGravity = false
                            selectedNode = node as? SKSpriteNode
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isPaused == false && selectedNode != nil && nodeSelected == true)
        {
            for t in touches
            {
                selectedNode?.position = t.location(in: self);
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        nodeSelected = false
        selectedNode?.physicsBody?.categoryBitMask = holdType!
        selectedNode?.physicsBody?.affectedByGravity = true
    }
    
    func Spawned()
    {
        temp = randArray
        switch randtype
        {
        case(0?):
            if(meatArray[randArray!]?.physicsBody?.affectedByGravity != true)
            {
                meatArray[randArray!]?.position = spawnPointArray[randLocal!]!
                meatArray[randArray!]?.physicsBody?.affectedByGravity = true;
                break
            }
            else
            {
                while (randArray == temp)
                {
                    temp = randArray
                    randArray = Int(arc4random_uniform(20))
                }
                Spawned()
                break
            }
        case(1?):
            if(fishArray[randArray!]?.physicsBody?.affectedByGravity != true)
            {
                fishArray[randArray!]?.position = spawnPointArray[randLocal!]!
                fishArray[randArray!]?.physicsBody?.affectedByGravity = true;
                break
            }
            else
            {
                while (randArray == temp)
                {
                    temp = randArray
                    randArray = Int(arc4random_uniform(20))
                }
                Spawned()
                break
            }
        case(2?):
            if(fruitArray[randArray!]?.physicsBody?.affectedByGravity != true)
            {
                fruitArray[randArray!]?.position = spawnPointArray[randLocal!]!
                fruitArray[randArray!]?.physicsBody?.affectedByGravity = true;
                break
            }
            else
            {
                while (randArray == temp)
                {
                    temp = randArray
                    randArray = Int(arc4random_uniform(20))
                }
                Spawned()
                break
            }
        case(3?):
            if(veggieArray[randArray!]?.physicsBody?.affectedByGravity != true)
            {
                veggieArray[randArray!]?.position = spawnPointArray[randLocal!]!
                veggieArray[randArray!]?.physicsBody?.affectedByGravity = true;
                break
            }
            else
            {
                while (randArray == temp)
                {
                    temp = randArray
                    randArray = Int(arc4random_uniform(20))
                }
                Spawned()
                break
            }
        case(4?):
            if(diaryArray[randArray!]?.physicsBody?.affectedByGravity != true)
            {
                diaryArray[randArray!]?.position = spawnPointArray[randLocal!]!
                diaryArray[randArray!]?.physicsBody?.affectedByGravity = true;
                break
            }
            else
            {
                while (randArray == temp)
                {
                    temp = randArray
                    randArray = Int(arc4random_uniform(20))
                }
                Spawned()
                break
            }
        case(5?):
            if(candyArray[randArray!]?.physicsBody?.affectedByGravity != true)
            {
                candyArray[randArray!]?.position = spawnPointArray[randLocal!]!
                candyArray[randArray!]?.physicsBody?.affectedByGravity = true;
                break
            }
            else
            {
                while (randArray == temp)
                {
                    temp = randArray
                    randArray = Int(arc4random_uniform(20))
                }
                Spawned()
                break
            }
            
        //some added stuff by swift
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    //MARK: - Rob's Reset
    func rePosition()
    {
        for item in meatArray
        {
            if( (item?.position.y)! <= redLineNode.position.y + 30 || ((item?.position.x)! >= meatBagNode.position.x - 30 && (item?.position.x)! <= meatBagNode.position.x + 30) && (item?.position.y)! <= meatBagNode.position.y + 40)
            {
                item?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                item?.physicsBody?.affectedByGravity = false;
                item?.position = offScreen!;
            }
        }
        for item in fishArray
        {
            if( (item?.position.y)! <= redLineNode.position.y + 30 || ((item?.position.x)! >= fishBagNode.position.x - 30 && (item?.position.x)! <= fishBagNode.position.x + 30) && (item?.position.y)! <= fishBagNode.position.y + 40)
            {
                item?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                item?.physicsBody?.affectedByGravity = false;
                item?.position = offScreen!;
            }
        }
        for item in fruitArray
        {
            if((item?.position.y)! <= redLineNode.position.y + 30 || ((item?.position.x)! >= fruitBagNode.position.x - 30 && (item?.position.x)! <= fruitBagNode.position.x + 30) && (item?.position.y)! <= fruitBagNode.position.y + 40)
            {
                item?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                item?.physicsBody?.affectedByGravity = false;
                item?.position = offScreen!;
            }
        }
        for item in veggieArray
        {
            if( (item?.position.y)! <= redLineNode.position.y + 30 || ((item?.position.x)! >= veggieBagNode.position.x - 30 && (item?.position.x)! <= veggieBagNode.position.x + 30) && (item?.position.y)! <= veggieBagNode.position.y + 40)
            {
                item?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                item?.physicsBody?.affectedByGravity = false;
                item?.position = offScreen!;
            }
        }
        for item in diaryArray
        {
            if( (item?.position.y)! <= redLineNode.position.y + 30 || ((item?.position.x)! >= diaryBagNode.position.x - 30 && (item?.position.x)! <= diaryBagNode.position.x + 30) && (item?.position.y)! <= diaryBagNode.position.y + 40)
            {
                item?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                item?.physicsBody?.affectedByGravity = false;
                item?.position = offScreen!;
            }
        }
        for item in candyArray
        {
            if( (item?.position.y)! <= redLineNode.position.y + 30 || ((item?.position.x)! >= candyBagNode.position.x - 30 && (item?.position.x)! <= candyBagNode.position.x + 30) && (item?.position.y)! <= candyBagNode.position.y + 40)
            {
                item?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                item?.physicsBody?.affectedByGravity = false;
                item?.position = offScreen!;
            }
        }
    }
    
    //MARK: - collision func
    func didBegin(_ contact: SKPhysicsContact) {
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        if(nodeB?.name == "RedLine" && (nodeA?.name == "Meat" || nodeA?.name == "Fish" || nodeA?.name == "Fruit" || nodeA?.name == "Veggie" || nodeA?.name == "Diary" || nodeA?.name == "Candy"))//hits redline
        {
            nodeA?.physicsBody?.affectedByGravity = false;
            nodeA?.position = offScreen!;
            AddScore(amount: -10);
            print(nodeA?.name)
        }
        else if(nodeA?.name == "RedLine" && (nodeB?.name == "Meat" || nodeB?.name == "Fish" || nodeB?.name == "Fruit" || nodeB?.name == "Veggie" || nodeB?.name == "Diary" || nodeB?.name == "Candy"))//hits redline
        {
            nodeB?.physicsBody?.affectedByGravity = false;
            nodeB?.position = offScreen!;
            AddScore(amount: -10);
            print(nodeB?.name)
        }
        else
        {
            //Hits Baskets A
            if(nodeA?.name == "Meat" && nodeB?.name == "MeatBasket")//hits meat
            {
                nodeA?.physicsBody?.affectedByGravity = false;
                nodeA?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeA?.name == "Fish" && nodeB?.name == "FishBasket")//hits fish
            {
                nodeA?.physicsBody?.affectedByGravity = false;
                nodeA?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeA?.name == "Fruit" && nodeB?.name == "FruitBasket")//hits fruit
            {
                nodeA?.physicsBody?.affectedByGravity = false;
                nodeA?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeA?.name == "Veggie" && nodeB?.name == "VeggieBasket")//hits veggie
            {
                nodeA?.physicsBody?.affectedByGravity = false;
                nodeA?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeA?.name == "Diary" && nodeB?.name == "DiaryBasket")//hits diary
            {
                nodeA?.physicsBody?.affectedByGravity = false;
                nodeA?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeA?.name == "Candy" && nodeB?.name == "CandyBasket")//hits candy
            {
                nodeA?.physicsBody?.affectedByGravity = false;
                nodeA?.position = offScreen!;
                AddScore(amount: 10);
            }
            
            //Hits Baskets B
            if(nodeB?.name == "Meat" && nodeA?.name == "MeatBasket")//hits meat
            {
                nodeB?.physicsBody?.affectedByGravity = false;
                nodeB?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeB?.name == "Fish" && nodeA?.name == "FishBasket")//hits fish
            {
                nodeB?.physicsBody?.affectedByGravity = false;
                nodeB?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeB?.name == "Fruit" && nodeA?.name == "FruitBasket")//hits fruit
            {
                nodeB?.physicsBody?.affectedByGravity = false;
                nodeB?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeB?.name == "Veggie" && nodeA?.name == "VeggieBasket")//hits veggie
            {
                nodeB?.physicsBody?.affectedByGravity = false;
                nodeB?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeB?.name == "Diary" && nodeA?.name == "DiaryBasket")//hits diary
            {
                nodeB?.physicsBody?.affectedByGravity = false;
                nodeB?.position = offScreen!;
                AddScore(amount: 10);
            }
            if(nodeB?.name == "Candy" && nodeA?.name == "CandyBasket")//hits candy
            {
                nodeB?.physicsBody?.affectedByGravity = false;
                nodeB?.position = offScreen!;
                AddScore(amount: 10);
            }
        }
    }
    
    func AddScore(amount: Int)
    {
        score += amount;
        scoreTextNode.text = "SCORE : \(score)"
    }
}
