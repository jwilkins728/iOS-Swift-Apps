//
//  Weather.swift
//  WeatherApp
//
//  Created by Ralph Cachero on 2/2/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _summary: String!
    private var _weatherURL: String!
    
    //Weather Temperature
    private var _currentTemp: String!
    private var _dayOneForecastTemp: String!
    private var _dayTwoForecastTemp: String!
    private var _dayThreeForecastTemp: String!
    private var _dayFourForecastTemp: String!
    private var _dayFiveForecastTemp: String!

    //Weather Image
    private var _currentImg: String!
    private var _dayOneForecastImg: String!
    private var _dayTwoForecastImg: String!
    private var _dayThreeForecastImg: String!
    private var _dayFourForecastImg: String!
    private var _dayFiveForecastImg: String!

    //Day of the week
    private var _currentDay: Int!
    private var _dayOneForecastDay: Int!
    private var _dayTwoForecastDay: Int!
    private var _dayThreeForecastDay: Int!
    private var _dayFourForecastDay: Int!
    private var _dayFiveForecastDay: Int!

    
    var summary: String
    {
        if _summary == nil
        {
            _summary = ""
        }
        return _summary
    }
    
    var currentTemp: String
    {
        if _currentTemp == nil
        {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    var dayOneForecastTemp: String
    {
            if _dayOneForecastTemp == nil
            {
                _dayOneForecastTemp = ""
            }
            return _dayOneForecastTemp
    }
    
    var dayTwoForecastTemp: String
        {
            if _dayTwoForecastTemp == nil
            {
                _dayTwoForecastTemp = ""
            }
            return _dayTwoForecastTemp
    }
    
    var dayThreeForecastTemp: String
        {
            if _dayThreeForecastTemp == nil
            {
                _dayThreeForecastTemp = ""
            }
            return _dayThreeForecastTemp
    }
    
    var dayFourForecastTemp: String
        {
            if _dayFourForecastTemp == nil
            {
                _dayFourForecastTemp = ""
            }
            return _dayFourForecastTemp
    }
    
    var dayFiveForecastTemp: String
        {
            if _dayFiveForecastTemp == nil
            {
                _dayFiveForecastTemp = ""
            }
            return _dayFiveForecastTemp
    }

    
    var currentImg: String
    {
        if _currentImg == nil
        {
            _currentImg = ""
        }
        return "\(_currentImg)_main"
    }
    
    var dayOneForecastImg: String
    {
        if _dayOneForecastImg == nil
        {
            _dayOneForecastImg = ""
        }
        return "\(_dayOneForecastImg)_forecast"
    }
    
    var dayTwoForecastImg: String
        {
            if _dayTwoForecastImg == nil
            {
                _dayTwoForecastImg = ""
            }
            return "\(_dayTwoForecastImg)_forecast"
    }
    
    var dayThreeForecastImg: String
        {
            if _dayThreeForecastImg == nil
            {
                _dayThreeForecastImg = ""
            }
            return "\(_dayThreeForecastImg)_forecast"
    }
    
    var dayFourForecastImg: String
        {
            if _dayFourForecastImg == nil
            {
                _dayFourForecastImg = ""
            }
            return "\(_dayFourForecastImg)_forecast"
    }
    
    var dayFiveForecastImg: String
        {
            if _dayFiveForecastImg == nil
            {
                _dayFiveForecastImg = ""
            }
            return "\(_dayFiveForecastImg)_forecast"
    }

    
    var currentDay: Int
    {
        return _currentDay
    }
    
    var dayOneForecastDay: Int
    {
        return _dayOneForecastDay
    }
    
    var dayTwoForecastDay: Int
    {
            return _dayTwoForecastDay
    }
    
    var dayThreeForecastDay: Int
    {
            return _dayThreeForecastDay
    }
    
    var dayFourForecastDay: Int
    {
            return _dayFourForecastDay
    }
    
    var dayFiveForecastDay: Int
    {
            return _dayFiveForecastDay
    }
    
    init() {
        
        _weatherURL = "\(BASE_URL)\(API_KEY)\(LATITUDE),\(LONGITUDE)"
    }
    
    func convertUnixTimeToDay(time: Int) -> String {
        let epocTime = NSTimeInterval(time)
        let myDate = NSDate(timeIntervalSince1970: epocTime)
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday], fromDate: myDate)
        var tmp = ""
        
        switch components.weekday
        {
            case 1: tmp = "Sunday"
            case 2: tmp = "Monday"
            case 3: tmp = "Tuesday"
            case 4: tmp = "Wednesday"
            case 5: tmp = "Thursday"
            case 6: tmp = "Friday"
            case 7: tmp = "Saturday"
            default: tmp = ""
        }
        
        return tmp
    }
    
    func downloadWeatherDetails(completed: DownloadComplete)
    {
        let url = NSURL(string: _weatherURL)!
        Alamofire.request(.GET, url).responseJSON
        { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                //Current Weather
                if let currently = dict["currently"] as? Dictionary<String,AnyObject>
                {
                    if let sum = currently["summary"] as? String
                    {
                        self._summary = sum
                    }
                    if let tmp = currently["temperature"] as? Int
                    {
                        self._currentTemp = "\(tmp)°F"
                    }
                    
                    if let day = currently["time"] as? Int
                    {
                        self._currentDay = day
                    }
                    
                    if let icon = currently["icon"] as? String
                    {
                        self._currentImg = icon
                    }
                    
                }
                
                //5-day forecast
                if let daily = dict["daily"] as? Dictionary<String,AnyObject>
                {
                    if let data = daily["data"] as? [Dictionary<String,AnyObject>] where data.count > 0
                    {
                        //Day One
                        if let firstDay = data[1]["time"] as? Int
                        {
                            self._dayOneForecastDay = firstDay
                        }
                        if let firstTemp = data[1]["temperatureMax"] as? Int
                        {
                            self._dayOneForecastTemp = "\(firstTemp)°F"
                        }
                        if let firstImg = data[1]["icon"] as? String
                        {
                            self._dayOneForecastImg = firstImg
                        }
                        
                        //Day Two
                        if let secondDay = data[2]["time"] as? Int
                        {
                            self._dayTwoForecastDay = secondDay
                        }
                        if let secondTemp = data[2]["temperatureMax"] as? Int
                        {
                            self._dayTwoForecastTemp = "\(secondTemp)°F"
                        }
                        if let secondImg = data[2]["icon"] as? String
                        {
                            self._dayTwoForecastImg = secondImg
                        }
                        
                        //Day Three
                        if let thirdDay = data[3]["time"] as? Int
                        {
                            self._dayThreeForecastDay = thirdDay
                        }
                        if let thirdTemp = data[3]["temperatureMax"] as? Int
                        {
                            self._dayThreeForecastTemp = "\(thirdTemp)°F"
                        }
                        if let thirdImg = data[3]["icon"] as? String
                        {
                            self._dayThreeForecastImg = thirdImg
                        }
                        
                        //Day Four
                        if let forthDay = data[4]["time"] as? Int
                        {
                            self._dayFourForecastDay = forthDay
                        }
                        if let forthTemp = data[4]["temperatureMax"] as? Int
                        {
                            self._dayFourForecastTemp = "\(forthTemp)°F"
                        }
                        if let forthImg = data[4]["icon"] as? String
                        {
                            self._dayFourForecastImg = forthImg
                        }
                        
                        //Day Five
                        if let fifthDay = data[5]["time"] as? Int
                        {
                            self._dayFiveForecastDay = fifthDay
                        }
                        if let fifthTemp = data[5]["temperatureMax"] as? Int
                        {
                            self._dayFiveForecastTemp = "\(fifthTemp)°F"
                        }
                        if let fifthImg = data[5]["icon"] as? String
                        {
                            self._dayFiveForecastImg = fifthImg
                        }
                    }
                }
            }
            completed()
        }
    }
}