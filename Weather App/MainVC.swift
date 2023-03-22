//
//  ViewController.swift
//  Weather App
//
//  Created by Osama Ramadan on 21/03/2023.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    @IBOutlet weak var EditLable: UIButton!
    @IBOutlet weak var loaderAct: UIActivityIndicatorView!
    var cityId : String = "358245"
    @IBOutlet weak var citynameLable: UILabel!
    @IBOutlet weak var pressureLable: UILabel!
    @IBOutlet weak var humLable: UILabel!
    @IBOutlet weak var tempLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name(rawValue: "CityValueChanged"), object: nil)
        EditLable.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
       getCityWeatherInfo()
        
        
    }
    func getCityWeatherInfo() {
        let params = ["id":cityId,"appid":"475a974f4b11688bd3dc8a91e348285d"
        ]
        
        self.loaderAct.isHidden = false
        loaderAct.startAnimating()
        
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value {
                let JSON = result as! NSDictionary
                let main = JSON["main"] as! NSDictionary
                var temp = main["temp"] as! Double
                let press = main["pressure"]as! Double
                let hum = main["humidity"]as! Double
                temp = temp - 277.15
                temp = Double(round(1000 * temp)/1000)
                self.loaderAct.stopAnimating()
                self.loaderAct.isHidden = true
                self.tempLable.text = "\(temp)°"
                self.pressureLable.text = "\(press)"
                self.humLable.text = "\(hum)"
            }
            
        }
    }
    @objc func cityChanged(notification : Notification){
        if let city = notification.userInfo?["city"]as? City {
            citynameLable.text = city.name
            cityId = city.id
            getCityWeatherInfo()
            
        }
        
    }
}

