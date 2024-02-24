//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = JustIntroViewModel()
    @State private var age = ""
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TimeInterval",
                       subtitle: "Introduction",
                       desc: "The Time Interval")
            .layoutPriority(1)
            
            Text("Abjust interval")
            Slider(
                value: $vm.interval,
                in: 0.1...1,
                minimumValueLabel: Image(systemName: "hare"),
                maximumValueLabel: Image(systemName: "tortoise"),
                label: {
                    Text("Interval")
                }
            )
            .padding(.horizontal)
            
            Button("Stop") {
                vm.stop()
            }
            
            List(vm.data, id: \.self) { text in
                Text(text)
                    .font(.system(.title, design: .monospaced))
            }
            
            .font(.title)
        }
        .onAppear() {
            vm.start()
        }
    }
}

#Preview {
    ContentView()
}
