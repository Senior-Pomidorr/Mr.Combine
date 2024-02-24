//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = DataTaskPublisher()
    @State private var age = ""
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TimeInterval",
                       subtitle: "Introduction",
                       desc: "The Time Interval")
            .layoutPriority(1)
            
            vm.dataToView?
                .resizable()
                .scaledToFit()
                
    
        }
        .onAppear() {
            vm.fetch()
        }
        .alert(item: $vm.errorForAlert) { errorForAlert in
            Alert(
                title: Text(
                    errorForAlert.title
                ),
                message: Text(errorForAlert.message)
            )
        }
    }
}

#Preview {
    ContentView()
}
