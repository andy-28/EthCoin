//
//  ContentView.swift
//  EthCoin
//
//  Created by 江啟綸 on 2022/4/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
