//
//  ViewController.swift
//  bitcointest
//
//  Created by Suraj Ramnani on 11/04/23.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, getCoinDataDelegate{
    func getCoinData(Currency: String, Price: String) {
        DispatchQueue.main.async {
            
            
            self.textView1.text = Price
           
            self.textView2.text = Currency
               }
           }
           
    
    
    func getError(error: Error) {
        print("error")
    }
    
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    var coins = coinData()

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coins.array.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coins.array[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coins.array[row]
        coins.getCurrency(Currency: selectedCurrency)
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coins.delegate = self
        CurrencyPicker.delegate = self
        CurrencyPicker.dataSource = self
      
    }


}

