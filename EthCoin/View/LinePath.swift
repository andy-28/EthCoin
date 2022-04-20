//
//  LinePath.swift
//  EthScenekit
//
//  Created by 江啟綸 on 2022/3/8.
//

import SwiftUI

struct LinePath: View {
    var data: [Double]
    
    @State var currentPlot = ""
    
    @State var offest: CGSize = .zero
    @State var showPlot = false
    @State var translation: CGFloat = 0
    
    @GestureState var isDrag: Bool = false
    
    var body: some View {
        
        GeometryReader{ proxy in
            
            let height = proxy.size.height
            let width = (proxy.size.width) / CGFloat(data.count - 1)
            
            let maxPoint = (data.max() ?? 0)
            let minPoint = data.min() ?? 0
            
            let points = data.enumerated().compactMap{ item -> CGPoint in
                
                let progress = (item.element - minPoint) / (maxPoint - minPoint)
                
                let pathHeight = progress * (height - 50)
                
                let pathWidth = width * CGFloat(item.offset)
                
                return CGPoint(x: pathWidth, y: -pathHeight + height)
            }
            
            ZStack{
                
                // Converting plot as points
                
                // Path...
                Path{path in
                    
                    // drawing the points
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLines(points)
                }
                .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round ))
                .fill(
                    // Gradient...
                    LinearGradient(
                        colors: [Color.pink, Color.purple], startPoint: .leading, endPoint: .trailing)
                )
            }
        }
        
    }
    
}

