//
//  ViewController.swift
//  bullzeye
//
//  Created by hyunho lee on 2020/02/24.
//  Copyright © 2020 hyunho lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighLighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighLighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }
    
    @IBAction func showAlert(){
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        let title: String
        
        if difference == 0{
            title = "Perfect!"
            points += 100
        }
        else if difference < 5 {
            title = "You almost get it!"
        }
        else if difference < 10 {
            title = "close!"
        }
        else {
            title = "not good...."
        }
        
        score += points
        
        let message = "당신이 획득한 점수는 \(points)점 입니다. \n당신이 선택한 값은 : \(currentValue) 입니다."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        round += 1
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    

}

