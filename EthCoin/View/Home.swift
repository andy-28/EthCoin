//
//  Home.swift
//  EthCoin
//
//  Created by 江啟綸 on 2022/4/12.
//

import SwiftUI
import SceneKit

struct Home: View {
    @State var currentCoin: String = "ETH"
    @Namespace var animation
    @StateObject var appModel: AppViewModel = AppViewModel()
    
    var body: some View {
        VStack {
            if let coins = appModel.coins,let coin = appModel.currentCoin{
                VStack{
                    Text("Ethereum(ETH)")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(15)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                            .opacity(0.02)
                        
                            .background(
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        .linearGradient(.init(colors: [
                                            
                                            Color.pink,
                                            .clear,
                                            Color.purple
                                        ]), startPoint: .topLeading, endPoint: .bottomTrailing )
                                        ,lineWidth: 6
                                    )
                            )
                        VStack{
                            SceneView(
                                scene: {
                                    let scene = SCNScene(named: "Ethereum_Coin.usdz")!
                                    scene.background.contents = UIColor.black
                                    
                                    return scene
                                }(),
                                options: [.autoenablesDefaultLighting,.allowsCameraControl]
                            )
                                .frame(width: 80, height: 80)
                        }
                        
                    }
                    .frame(width: 100, height: 100)
                    .padding(20)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
//                CustomControl(coins: coins)
                
                VStack(alignment: .center, spacing: 8) {
                    Text(coin.current_price.convertToCurrency())
                        .font(.largeTitle.bold())
                    
                    Text("\(coin.price_change > 0 ? "+" : "-")\(String(format: "%.2f", coin.price_change))")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(coin.price_change < 0 ? .red :Color.green)
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
//                        .background{
//                            Capsule()
//                                .fill(coin.price_change < 0 ? .red :Color.green)
//                        }
                }
                .frame(maxWidth: .infinity, alignment: .center)

                GraphView(coin: coin)
                
                Controls()
            }
            else{
                ProgressView()
                    .tint(Color.green)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    
    //MARK: - Line Graph
    @ViewBuilder
    func GraphView(coin: CryptoModel)->some View {
        GeometryReader{_ in
            LinePath(data: coin.last_7days_price.price)
        }
        .padding(.vertical,10)
        .padding(.bottom,20)
    }
    
    //MARK: - Custom Segmented Control
    @ViewBuilder
    func CustomControl(coins: [CryptoModel])->some View{
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(coins){coin in
                    Text(coin.symbol.uppercased())
                        .foregroundColor(currentCoin == coin.symbol.uppercased() ? .white : .gray)
                        .padding(.vertical,6)
                        .padding(.horizontal,10)
                        .contentShape(Rectangle())
                        .background{
                            if currentCoin == coin.symbol.uppercased() {
                                Rectangle()
                                    .fill(.blue)
                                    .matchedGeometryEffect(id: "SEGMENTEDTAB", in: animation)
                            }
                        }
                        .onTapGesture {
                            appModel.currentCoin = coin
                            withAnimation{currentCoin = coin.symbol.uppercased()}
                        }
                }
            }
        }
        .background{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(Color.white.opacity(0.2),lineWidth: 1)
        }
        .padding(.vertical)
    }
    
    //MARK: - Controls
    @ViewBuilder
    func Controls()->some View {
        HStack(spacing: 20) {
//            Button {} label: {
//                Text("1D")
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical)
//                    .background{
//                        RoundedRectangle(cornerRadius: 12, style: .continuous)
//                            .fill(.white)
//                    }
//            }
//            Button {} label: {
//                Text("7D")
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical)
//                    .background{
//                        RoundedRectangle(cornerRadius: 12, style: .continuous)
//                            .fill(.white)
//                    }
//            }
//            Button {} label: {
//                Text("1M")
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical)
//                    .background{
//                        RoundedRectangle(cornerRadius: 12, style: .continuous)
//                            .fill(.white)
//                    }
//            }
            Text("1D")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            .linearGradient(.init(colors: [
                                
                                Color.gray,
                                Color.gray
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing )
                            ,lineWidth: 2
                        )
                )
                .padding(20)
            Text("7D")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            .linearGradient(.init(colors: [
                                
                                Color.pink,
                                Color.purple
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing )
                            ,lineWidth: 2
                        )
                )
                .padding(20)
            Text("1M")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            .linearGradient(.init(colors: [
                                
                                Color.gray,
                                Color.gray
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing )
                            ,lineWidth: 2
                        )
                )
                .padding(20)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Coverting Double to Currency

extension Double{
    func convertToCurrency()->String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: .init(value: self)) ?? ""
    }
}
 
