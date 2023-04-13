//
//  coinData.swift
//  bitcointest
//
//  Created by Suraj Ramnani on 11/04/23.
//

import Foundation

protocol getCoinDataDelegate {
    
    func getCoinData(Currency: String, Price: String)
    func getError(error:Error)
}


struct coinData

{
  
    var delegate: getCoinDataDelegate?
    let url = "https://api.coincap.io/v2/assets"
    let array =  ["BTC", "ETH", "LTC", "XRP", "BCH", "EOS", "ETC", "ZEC", "BAT"]
    
    func getCurrency(Currency: String) {
        let url = "https://api.coincap.io/v2/markets?baseSymbol=\(Currency)"
        if let urlString = URL(string: url) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let currencyPricing = ParseJSON(dataCapture: safeData) {
                        self.delegate?.getCoinData(Currency: Currency, Price: currencyPricing.priceUsd!)
                        
                    }
                }
                
            }
            task.resume()
        }
        
    }
    func ParseJSON(dataCapture: Data) -> data? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinStructure.self, from: dataCapture)
            let id = decodedData.data[0].rank
            let symbol = decodedData.data[0].baseSymbol
            let price = decodedData.data[0].priceUsd
            let coinInfo = data(rank: id, baseSymbol: symbol, priceUsd: price)
            return coinInfo
        } catch let error {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}


