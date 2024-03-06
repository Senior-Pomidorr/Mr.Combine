//
//  CollectByView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI

struct CollectByView: View {
    @StateObject private var vm = CollectByTime()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Collect By Time",
                           subtitle: "Introduction",
                           desc: "Collect By Time")
                
                Slider(value: $vm.timeInterval, in: 2...4, step: 1,
                       minimumValueLabel: Text("2"),
                       maximumValueLabel: Text("4"),
                       label:{ })
            }
            .padding(.horizontal)
            
            Button("Stop") {
                vm.stop()
            }
            List(vm.collections, id: \.self) { item in
                Text(item.joined(separator: ","))
            }
            .font(.title)
        }
        //        .alert(item: $vm.error, content: { error in
        //            Alert(title: Text("Error"), message: Text(error.description))
        //        })
        .onAppear() {
            vm.fetch()
        }
    }
}

#Preview {
    CollectByView()
}
