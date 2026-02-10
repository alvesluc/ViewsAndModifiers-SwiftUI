//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Macedo on 04/02/26.
//

import SwiftUI

struct ContentView: View {
    struct CapsuleText: View {
        var text: String
        
        var body: some View {
            Text(text)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(.capsule)
        }
    }
    
    struct Title: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
    
    struct Watermark: ViewModifier {
        var text: String
        
        func body(content: Content) -> some View {
            ZStack(alignment: .bottomTrailing) {
                content
                Text(text)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.orange)
                    .clipShape(.rect(topLeadingRadius: 8))
                    .opacity(0.5)
            }
        }
    }
    
    struct LargeBlueTitle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundStyle(.blue)
                .font(.largeTitle)
        }
    }
    
    struct GridStack<Content: View>: View {
        let rows: Int
        let columns: Int
        let content: (Int, Int) -> Content
        
        @ViewBuilder var body: some View {
            VStack {
                ForEach(0..<rows, id: \.self) { row in
                    HStack {
                        ForEach(0..<columns, id: \.self) { column in
                            content(row, column)
                        }
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
            Text("Well hello there!")
                .titleStyle()
            
            Color.blue
                .frame(width: 320, height: 180)
                .watermarked(with: "@swiftdevlog")
            
            GridStack(rows: 4, columns: 4) { row, col in
                Text("R\(row):C\(col)")
                    .fontDesign(.monospaced)
            }
            
            Text("Challenge")
                .largeBlueTitle()
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(ContentView.Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(ContentView.Watermark(text: text))
    }
    
    func largeBlueTitle() -> some View {
        modifier(ContentView.LargeBlueTitle())
    }
}

