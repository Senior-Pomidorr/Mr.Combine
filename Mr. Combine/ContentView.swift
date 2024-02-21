//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var vm = CurrentValueSubjectViewModel()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("CurrentValueSubject",
                       subtitle: "Compared",
                       desc: "Let's compare with @Published. The map operator will work now                               because the @Published property's value doesn't actually change                               until AFTER the pipeline has finished.")
            
            Button("Selected Lorenzo") {
                vm.selection.send("Lorenzo")
            }
            
            Button("Selected Elen") {
                vm.selection.send("Elen")
            }
            
            Text(vm.selection.value)
                .foregroundStyle(vm.selectionSame.value ? .red : .green)
        }
        .font(.title)
        
    }
}

#Preview {
    ContentView()
}
