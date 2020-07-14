//
//  ViewController.swift
//  02-Dices
//
//  Created by Ricardo Sanchez on 6/26/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageViewDiceLeft: UIImageView!
    @IBOutlet weak var imageViewDiceRight: UIImageView!
    @IBOutlet weak var labelResult: UILabel!
    
    var randomDiceIndexLeft: Int = 0
    var randonmDiceIndexRight: Int = 0
    let diceImages: [String]
    let nFaces : UInt32
    
    required init?(coder: NSCoder) {
        diceImages = ["dice1", "dice2", "dice3" ,"dice4" ,"dice5", "dice6"]
        nFaces = UInt32(diceImages.count)
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelResult.isHidden = true
        generateRamdomDices()
    }

    @IBAction func rollPressed(_ sender: Any) {
        generateRamdomDices()
    }
    
    func generateRamdomDices() {
        
        randomDiceIndexLeft = Int(arc4random_uniform(nFaces))
        randonmDiceIndexRight = Int(arc4random_uniform(nFaces))
        let resultado = (randomDiceIndexLeft + 1 ) + (randonmDiceIndexRight + 1)
        labelResult.text = "\(resultado)"
        labelResult.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi*(-1)/2)).concatenating(CGAffineTransform(translationX: -100, y: 100))
            self.imageViewDiceRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi*(-1)/2)).concatenating(CGAffineTransform(translationX: 100, y: 100))
            
            self.imageViewDiceLeft.alpha = 0.0
            self.imageViewDiceRight.alpha = 0.0
            self.labelResult.transform = CGAffineTransform(scaleX: 2, y: 2).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi)).concatenating(CGAffineTransform(translationX: 10, y: 0))
            
        }) { (completed) in
            self.imageViewDiceLeft.transform = CGAffineTransform.identity
            self.imageViewDiceRight.transform = CGAffineTransform.identity
            self.imageViewDiceLeft.alpha = 1.0
            self.imageViewDiceRight.alpha = 1.0
            self.labelResult.transform = CGAffineTransform.identity
            self.imageViewDiceLeft.image = UIImage(named: self.diceImages[self.randomDiceIndexLeft])
            self.imageViewDiceRight.image = UIImage(named: self.diceImages[self.randonmDiceIndexRight])
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            generateRamdomDices()
        }
        
    }
    
}

