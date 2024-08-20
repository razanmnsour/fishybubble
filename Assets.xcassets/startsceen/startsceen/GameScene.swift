//
//  GameScene.swift
//  startsceen
//
//  Created by RAZAN MNSOUR on 16/02/1446 AH.
//

import SpriteKit

class StartScene: SKScene {
    
    override func didMove(to view: SKView) {
        // إضافة خلفية من الassets
        let background = SKSpriteNode(imageNamed: "startbackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        background.size = self.size
        addChild(background)
        
        // تشغيل حركة الفقاعات
        runBubblesAnimation()
        
        // الانتظار لمدة 5 ثواني ثم إظهار زر Play
        run(SKAction.sequence([
            SKAction.wait(forDuration: 5.0),
            SKAction.run(showPlayButton)
        ]))
    }
    
    // دالة حركة الفقاعات
    func runBubblesAnimation() {
        let bubble = SKSpriteNode(imageNamed: "bubble") // صورة الفقاعات من الأصول
        bubble.position = CGPoint(x: frame.maxX, y: CGFloat.random(in: frame.minY...frame.maxY))
        bubble.setScale(0.5)
        addChild(bubble)
        
        // حركة الفقاعات من اليمين إلى اليسار
        let moveLeft = SKAction.moveBy(x: -frame.width - bubble.size.width, y: 0, duration: 5.0)
        let removeBubble = SKAction.removeFromParent()
        bubble.run(SKAction.sequence([moveLeft, removeBubble]))
        
        // إعادة تشغيل الحركة كل ثانية
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(runBubblesAnimation),
            SKAction.wait(forDuration: 1.0)
        ])))
    }
    
    // دالة لإظهار زر "Play"
    func showPlayButton() {
        let playButton = SKSpriteNode(imageNamed: "playbutton") // صورة زر Play من الأصول
        playButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        playButton.name = "playButton"
        playButton.setScale(1.0)
        addChild(playButton)
        
        // جعل الزر يتفاعل مع اللمس
        playButton.isUserInteractionEnabled = false
    }
    
    // التعامل مع لمس الشاشة
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location)
        
        if touchedNode.name == "playButton" {
            // عند الضغط على زر Play، ابدأ حركة الفقاعات لمدة 3 ثواني ثم انتقل إلى GameScene
            touchedNode.removeFromParent() // إزالة الزر بعد الضغط عليه
            run(SKAction.sequence([
                SKAction.run(runBubblesAnimation),
                SKAction.wait(forDuration: 3.0),
                SKAction.run(goToGameScene)
            ]))
        }
    }
    
    // الانتقال إلى صفحة GameScene
    func goToGameScene() {
        if let gameScene = GameScene(fileNamed: "GameScene") {
            gameScene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 1.0)
            view?.presentScene(gameScene, transition: transition)
        }
    }
}
