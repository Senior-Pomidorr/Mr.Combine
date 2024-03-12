//
//  CollectBy.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI
import Combine

struct CollectBy: View {
    @StateObject private var vm = CollectByModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Collect By",
                           subtitle: "Introduction",
                           desc: "Collect By")
                
                Slider(value: $vm.teamSize, in: 2...4, step: 1,
                       minimumValueLabel: Text("2"),
                       maximumValueLabel: Text("4"),
                       label:{ })
            }
            .padding(.horizontal)
            
            
            List(vm.teams, id: \.self) { item in
                Text(item.joined(separator: ","))
            }
            .font(.title)
        }
        .onAppear() {
            vm.fetch()
        }
    }
}


#Preview {
    CollectBy()
}
