//
//  CoinStructure.swift
//  bitcointest
//
//  Created by Suraj Ramnani on 11/04/23.
//

import Foundation

struct CoinStructure: Codable
{
    let data: [data]
    
    struct data: Codable
    {
        let id: String
        let symbol: String
        let priceUsd: String
    }
    
}

