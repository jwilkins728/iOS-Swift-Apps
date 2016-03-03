//
//  ViewController.swift
//  TemperatureCalculator
//
//  Created by Ralph Cachero on 10/23/15.
//  Copyright © 2015 Teradek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var FahrenheitLabel: UILabel!
    @IBOutlet weak var CelsiusLabel: UILabel!
    @IBOutlet weak var Slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func TempChange(sender: AnyObject) {
        
        FahrenheitLabel.text = String(format: "%4.0f Fahrenheit", Slider.value)
        
        let fahrenheit = Slider.value
        let celsius = (fahrenheit - 32) / 1.8
        
        let result = String(format: "%4.1f Celsius", celsius)
        CelsiusLabel.text = result
    }
    
    
}

