//
//  GameViewController.swift
//  DoNotAssignAgencyToThePolyhedron
//
//  Created by Troy Adams on 1/23/20.
//  Copyright © 2020 Troy Adams. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var newDiceImageView: UIImageView!
    @IBOutlet weak var newCriticalLabel: UILabel!
    
    var rollySounds: AVAudioPlayer?
    var failSounds: AVAudioPlayer?
    var winnySounds: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rollPath = Bundle.main.path(forResource: "rolldice.mp3", ofType:nil)!
        let rollUrl = URL(fileURLWithPath: rollPath)
        do{
            rollySounds = try AVAudioPlayer(contentsOf: rollUrl)
        }catch{
            // sucks to be you
        }
        
        let failPath = Bundle.main.path(forResource: "failwah.mp3", ofType:nil)!
        let failUrl = URL(fileURLWithPath: failPath)
        do{
            failSounds = try AVAudioPlayer(contentsOf: failUrl)
        }catch{
            // sucks to be you
        }
        
        let winnyPath = Bundle.main.path(forResource: "zfanfare.mp3", ofType:nil)!
        let winnyUrl = URL(fileURLWithPath: winnyPath)
        do{
            winnySounds = try AVAudioPlayer(contentsOf: winnyUrl)
        }catch{
            // sucks to be you
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func rollDice(){
        let rolledNumber = Int.random(in: 1...20)
        let imageName = "d\(rolledNumber)"
        newDiceImageView.image = UIImage(named: imageName)
        
        rollySounds?.currentTime = 0
        rollySounds?.play()
        
        if (imageName == "d1"){
            newCriticalLabel.text = "That's tough, chief."
            newCriticalLabel.isHidden = false
            failSounds?.currentTime = 0
            failSounds?.play()
        }else if (imageName == "d20"){
            newCriticalLabel.text = "Oh nice."
            newCriticalLabel.isHidden = false
            winnySounds?.currentTime = 0
            winnySounds?.play()
        }else{
            newCriticalLabel.isHidden = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        rollDice()
    }
    
    
    @IBAction func rollDiceThing(_ sender: Any) {
        rollDice()
    }
    
}
