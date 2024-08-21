//
//  GameScene.swift
//  fishybubble
//
//  Created by RAZAN MNSOUR on 16/02/1446 AH.
//

import SpriteKit

class GameScene: SKScene {
    
    // دالة لتهيئة الصفحة وإضافة العناصر
    override func didMove(to view: SKView) {
        addBackground()
        addFishyBubbles()
        runBubbleAnimation()
    }
    
    // إضافة الخلفية
    func addBackground() {
        let background = SKSpriteNode(imageNamed: "startbackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: 760, height: 350)
        background.zPosition = -1
        addChild(background)
    }
    
    // إضافة fishybubbles مع حركة تكبير وتصغير
    func addFishyBubbles() {
        let fishyBubbles = SKSpriteNode(imageNamed: "fishybubbles")
        fishyBubbles.position = CGPoint(x: 0, y: 50) // وضع الصورة في أعلى الصفحة
        fishyBubbles.size = CGSize(width: 300, height: 70)
        //fishyBubbles.setScale(0.8)
        fishyBubbles.zPosition = 3
        addChild(fishyBubbles)
        
        // حركة التكبير والتصغير
        let scaleUp = SKAction.scale(to: 1.2, duration: 1.0)
        let scaleDown = SKAction.scale(to: 0.8, duration: 1.0)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatAction = SKAction.repeatForever(scaleSequence)
        fishyBubbles.run(repeatAction)
    }
    
    // إضافة الفقاعات بشكل عشوائي
    func runBubbleAnimation() {
        let createBubble = SKAction.run {
            let bubble = SKSpriteNode(imageNamed: "bubbles")
            let randomYPosition = CGFloat.random(in: self.frame.minY...self.frame.maxY)
            bubble.position = CGPoint(x: self.frame.minX, y: randomYPosition)
            bubble.setScale(0.5)
            self.addChild(bubble)
            
            // حركة الفقاعة من اليسار إلى اليمين
            let moveRight = SKAction.moveBy(x: self.frame.width + bubble.size.width, y: 0, duration: 5.0)
            let removeBubble = SKAction.removeFromParent()
            let bubbleSequence = SKAction.sequence([moveRight, removeBubble])
            bubble.run(bubbleSequence)
        }
        
        // تكرار ظهور الفقاعات 5 مرات
        let wait = SKAction.wait(forDuration: 0.5)
        let bubbleSequence = SKAction.sequence([createBubble, wait])
        let repeatBubbles = SKAction.repeat(bubbleSequence, count: 5)
        
        run(repeatBubbles) {
            self.showPlayButton() // عرض زر اللعب بعد انتهاء الفقاعات
        }
    }
    
    // إضافة زر Play بعد انتهاء الفقاعات
    func showPlayButton() {
        let playButton = SKSpriteNode(imageNamed: "playbutton")
        playButton.position = CGPoint(x: 0, y: frame.midY - 50)
        playButton.setScale(0.8)
        playButton.name = "playButton"
        addChild(playButton)
        
        playButton.isUserInteractionEnabled = false
    }
    
    // التعامل مع لمسات الشاشة (مثلاً عند النقر على زر Play)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode.name == "playButton" {
                // هنا يمكنك إضافة الأكشن الذي يتم عند النقر على زر Play
                print("Play Button Pressed")
            }
        }
    }
}
