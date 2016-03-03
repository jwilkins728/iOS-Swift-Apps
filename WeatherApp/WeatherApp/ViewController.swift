//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ralph Cachero on 2/1/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var summaryLbl: UILabel!

    //Image Outlet
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var dayOneForecastImg: UIImageView!
    @IBOutlet weak var dayTwoForecastImg: UIImageView!
    @IBOutlet weak var dayThreeForecastImg: UIImageView!
    @IBOutlet weak var dayFourForecastImg: UIImageView!
    @IBOutlet weak var dayFiveForecastImg: UIImageView!
    
    //Temperature Outlet
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var dayOneForecastTempLbl: UILabel!
    @IBOutlet weak var dayTwoForecastTempLbl: UILabel!
    @IBOutlet weak var dayThreeForecastTempLbl: UILabel!
    @IBOutlet weak var dayFourForecastTempLbl: UILabel!
    @IBOutlet weak var dayFiveForecastTempLbl: UILabel!

    //Day Outlet
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var dayOneForecastDayLbl: UILabel!
    @IBOutlet weak var dayTwoForecastDayLbl: UILabel!
    @IBOutlet weak var dayThreeForecastDayLbl: UILabel!
    @IBOutlet weak var dayFourForecastDayLbl: UILabel!
    @IBOutlet weak var dayFiveForecastDayLbl: UILabel!
    
    var weather =  Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI()
    {
        summaryLbl.text = weather.summary
        
        //Images
        currentWeatherImg.image = UIImage(named: weather.currentImg)
        dayOneForecastImg.image = UIImage(named: weather.dayOneForecastImg)
        dayTwoForecastImg.image = UIImage(named: weather.dayTwoForecastImg)
        dayThreeForecastImg.image = UIImage(named: weather.dayThreeForecastImg)
        dayFourForecastImg.image = UIImage(named: weather.dayFourForecastImg)
        dayFiveForecastImg.image = UIImage(named: weather.dayFiveForecastImg)
        
        //Temperature
        currentTempLbl.text = weather.currentTemp
        dayOneForecastTempLbl.text = weather.dayOneForecastTemp
        dayTwoForecastTempLbl.text = weather.dayTwoForecastTemp
        dayThreeForecastTempLbl.text = weather.dayThreeForecastTemp
        dayFourForecastTempLbl.text = weather.dayFourForecastTemp
        dayFiveForecastTempLbl.text = weather.dayFiveForecastTemp

        //Days
        currentDayLbl.text = weather.convertUnixTimeToDay(weather.currentDay).uppercaseString
        dayOneForecastDayLbl.text = weather.convertUnixTimeToDay(weather.dayOneForecastDay)
        dayTwoForecastDayLbl.text = weather.convertUnixTimeToDay(weather.dayTwoForecastDay)
        dayThreeForecastDayLbl.text = weather.convertUnixTimeToDay(weather.dayThreeForecastDay)
        dayFourForecastDayLbl.text = weather.convertUnixTimeToDay(weather.dayFourForecastDay)
        dayFiveForecastDayLbl.text = weather.convertUnixTimeToDay(weather.dayFiveForecastDay)
    }
    
}

