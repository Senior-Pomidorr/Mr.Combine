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
            HeaderView("Sequence",
                       subtitle: "Introduction",
                       desc: "The Sequence")
            .layoutPriority(1)
            
            List(vm.dataToView, id:\.self) { item in
                Text(item)
                
            }
            .font(.title)
        }
        .onAppear() {
            vm.fetch()
        }
    }
}

#Preview {
    ContentView()
}
