//
//  ChangeCityVC.swift
//  Weather App
//
//  Created by Osama Ramadan on 21/03/2023.
//

import UIKit

class ChangeCityVC: UIViewController {
   
    var citiesArray = [City(name: "Cairo", id: "360630"),
                       City(name: "Giza", id: "360995"),
                       City(name: "Luxor", id: "360502"),
                       City(name: "Dahab", id: "358245")
    ]
    
    
    var selectedCity : City?
    @IBOutlet weak var CitiesView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CitiesView.delegate = self
        CitiesView.dataSource = self
    }
    

    @IBAction func EditCityButtom(_ sender: Any) {
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CityValueChanged"), object: nil ,userInfo:["city":city] )
            self.dismiss(animated: true ,completion: nil)
        }
    }
    

}
extension ChangeCityVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        citiesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArray[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = citiesArray[row]
    }
    
    
}
