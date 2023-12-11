//
//  ViewController.swift
//  Wetter App Test
//
//  
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
   
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // Zeit und Datum
    var timer = Timer()
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        
        // Zeit und Datum -> ruft jede Sekunde self.currenTime auf
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.currenTime), userInfo: nil, repeats: true)
        
        setDate()
    }
    
    // Suchbutton drücken
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    //MARK: Funktion wenn Nutzer auf Bildschirm drückt, spirng in zweiten Screen
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?){
        performSegue(withIdentifier: "moreWeatherInfo", sender: nil)
        
    }
    
    //MARK: Zeit laden
    @objc func currenTime() {
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm:ss"
        timeLabel.text = formater.string(from: Date())
    }
    
    //MARK: Datum anzeigen
    func setDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "de_DE")
        dateLabel.text = formatter.string(from: Date())
    }
    
    //MARK: Funktionen aus dem Protocol UITextFieldDelegate
    //Meldung es hat jemand auf den Button gedrückt, soll ich die Tastatur einfahren
    // Funktionen aus dem Protocol UITextFieldDelegate
    
    // Meldung: - Es hat jemand auf den Return Button gedrückt, ööö soll ich die Tastatur einfahren?
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    // Meldung: Es hat jemand das tippen beendet, ööö soll ich die Tastatur einfahren?
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            let alert = UIAlertController(title: "Achtung", message: "Bitte Stadt eingeben", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    // Meldung: Es hat jemand das tippen beendet, fahre die Tastatur ein!
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Suche nach den Wetterdaten starten
        
        //OptinoalBinding um zu Prüfen ob was drin ist
        if let _cityName = searchTextField.text {
            // Die Suche starten
            print(_cityName)
            weatherManager.fetchWeather(cityName: _cityName)
        }
        // leert das Suchfeld wieder
        searchTextField.text = ""
    }
    
    // Dadurch das es ein Protocoll ist muss man es "fertig" machen
    func didUpdateWeather(weather: WeatherModel) {
        // sorgt dafür, dass die Daten erst geladen werden und dann angezeigt da App sonst Abstürtzt
        DispatchQueue.main.async{
            self.tempLabel.text = String(weather.temperature)
            self.cityNameLabel.text = weather.cityName
            self.statusLabel.text = weather.description
            self.weatherImageView.image = UIImage (systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    
    
    
}

