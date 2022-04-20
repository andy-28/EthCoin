//
//  AppViewModel.swift
//  EthCoin
//
//  Created by 江啟綸 on 2022/4/12.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var coins: [CryptoModel]?
    @Published var currentCoin: CryptoModel?
    
    init() {
        Task{
            do{
                try await fetchCryptoData()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Fetching Crypto Data
    func fetchCryptoData()async throws {
        
        guard let url = url else{return}
        let session = URLSession.shared
        
        let response = try await session.data(from: url)
        let jsonData = try JSONDecoder().decode([CryptoModel].self, from: response.0)
        
        await MainActor.run(body: {
            self.coins = jsonData
            if let firstCoin = jsonData.first {
                self.currentCoin = firstCoin
            }
        })
    }
}


