//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var vm = YourFirstPipeline()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Published",
                       subtitle: "Introduction",
                       desc: "«The @Published property wrapper has a built-in publisher that you                              can access with the dollar sign ($).")
            TextEditor(text: $vm.data)                .border(Color.gray, width: 1)                .frame(height: 200)
                .padding()
            
            Text("\(vm.count)/\(vm.characterLimit)")                .foregroundStyle(vm.color)
        }
        .font(.title)
        
    }
}

#Preview {
    ContentView()
}
