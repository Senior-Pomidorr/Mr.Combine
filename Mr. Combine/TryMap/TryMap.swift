//
//  TryMap.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 21.11.2024.
//

import SwiftUI

struct TryMap: View {
    @StateObject private var vm = TryMapVM()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TryMap",
                       subtitle: "Introduction",
                       desc: "The tryMap operator will allow you to throw an error inside its closure.")
            Button("Error") {
                vm.simulateError()
            }
            List(vm.dataOut, id: \.self) { item in
                Text(item)
            }
        }
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message))
        }
        .onAppear {
            vm.fetch()
        }
    }
}

#Preview {
    TryMap()
}
