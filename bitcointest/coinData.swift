//
//  coinData.swift
//  bitcointest
//
//  Created by Suraj Ramnani on 11/04/23.
//

import Foundation

protocol getCoinDataDelegate {
    
    func getCoinData(Currency: String, Price: Double)
    func getError(error:Error)
}


struct coinData

{
  
    var delegate: getCoinDataDelegate?
    let url = "https://api.coincap.io/v2/assets"
    let array = ["bitcoin", "ethereum", "tether","binance-coin","usd-coin","xrp","cardano","dogecoin"]
    
    func getCurrency(Currency: String) {
        
        if let urlString = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let currencyPricing = ParseJSON(dataCapture: safeData) {
                        
                       
                        self.delegate?.getCoinData(Currency: Currency, Price: currencyPricing)
                        print(currencyPricing)
                    }
                }
                
            }
            task.resume()
        }
        
    }
    func ParseJSON(dataCapture: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinStructure.self, from: dataCapture)
            let id = decodedData.data[0].id
            let symbol = decodedData.data[0].symbol
            let price = decodedData.data[0].priceUsd
            guard let price = Double(price) else {
                        print("Unable to convert price to a double.")
                        return nil
                    }
            let coinInfo = CoinInfo(id: id, symbol: symbol, priceUsd: price)
            return price
        } catch let error {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}


