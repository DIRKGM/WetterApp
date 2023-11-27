//
//  ViewController.swift
//  Wetter App Test
//
//  
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // Zeit und Datum
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
