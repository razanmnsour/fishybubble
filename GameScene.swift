//  GameScene.swift
//  ClickyFishy
//  Created by RAZAN MNSOUR on 11/02/1446 AH.

import SpriteKit

class GameScene: SKScene {
    // المتغيرات الأساسية
    var score = 0
    var timer = 60
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var gameTimer: Timer!
    let puseButton = SKSpriteNode(imageNamed: "puse")
    // أسماء السمكات المتاحة في الـ Assets
    let fishTextures = ["fish", "fish1", "fish2", "fish3"]
    override func didMove(to view: SKView) {
        // إعداد الخلفية
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.size = self.size
        background.zPosition = -1
        self.addChild(background)
        // إعداد scoreLabel
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.frame.midX - 500, y: self.frame.maxY - 85)
        self.addChild(scoreLabel)
        // إعداد timerLabel
        timerLabel = SKLabelNode(fontNamed: "Arial")
        timerLabel.text = "Time: 60"
        timerLabel.fontSize = 36
        timerLabel.fontColor = SKColor.white
        timerLabel.position = CGPoint(x: self.frame.maxX - 200, y: self.frame.maxY - 85)
        self.addChild(timerLabel)
        // استدعاء وظيفة تحديث المؤقت كل ثانية
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        // إضافة عدة سمكات بشكل عشوائي
        for _ in 1...5 { // هنا نضيف 5 سمكات كبداية
            addFish()
        }
        setupUI()
    }
    @objc func updateTimer() {
        if timer > 0 {
            timer -= 1
            timerLabel.text = "Time: \(timer)"
        } else {
            // إيقاف اللعبة عند انتهاء الوقت
            gameTimer.invalidate()
            timerLabel.text = "Time: 0"
        }
    }
    func addFish() {
        // اختيار صورة السمكة بشكل عشوائي من الـ Assets
        let randomFishTexture = fishTextures.randomElement() ?? "fish"
        let fish = SKSpriteNode(imageNamed: randomFishTexture)
        fish.name = "fish"
        // ضبط حجم السمكة
        fish.size = CGSize(width: 100, height: 50)
        // تحديد حدود الشاشة مع الأخذ بعين الاعتبار حجم السمكة
        let fishWidthHalf = fish.size.width / 2
        let fishHeightHalf = fish.size.height / 2
        let minX = frame.minX + fishWidthHalf
        let maxX = frame.maxX - fishWidthHalf
        let minY = frame.minY + fishHeightHalf
        let maxY = frame.maxY - fishHeightHalf
        // تحديد موقع عشوائي داخل الحدود
        let randomX = CGFloat.random(in: minX...maxX)
        let randomY = CGFloat.random(in: minY...maxY)
        fish.position = CGPoint(x: randomX, y: randomY)
        self.addChild(fish)
        // تحريك السمكة بشكل عشوائي
        let moveAction = SKAction.moveBy(x: CGFloat.random(in: -100...100), y: CGFloat.random(in: -100...100), duration: 1.0)
        let repeatAction = SKAction.repeatForever(SKAction.sequence([moveAction, moveAction.reversed()]))
        fish.run(repeatAction)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodesArray = self.nodes(at: location)
            if let tappedNode = nodesArray.first as? SKSpriteNode, tappedNode.name == "fish" {
                // حدث اللمس مع السمكة
                score += 3
                scoreLabel.text = "Score: \(score)"
                tappedNode.removeFromParent()
                // إضافة سمكة جديدة بعد الضغط على سمكة
                addFish()
            }
        }
        
    }
    func setupUI(){
        puseButton.position = CGPoint(x: 550, y: 213)
        puseButton.size = CGSize(width: 86, height: 89)
        puseButton.zPosition = 5
        puseButton.name = "puse"
        self.addChild(puseButton)
    }
}

