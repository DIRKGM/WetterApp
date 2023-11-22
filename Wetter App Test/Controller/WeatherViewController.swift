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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Suchbutton drücken
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    //MARK: Funktion wenn Nutzer auf Bildschirm drückt
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?){
            print("Test")

  }
    
}
