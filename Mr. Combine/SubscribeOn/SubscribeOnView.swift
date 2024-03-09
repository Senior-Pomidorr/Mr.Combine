//
//  SubscribeOnView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/9/24.
//

import SwiftUI

struct SubscribeOnView: View {
    @StateObject private var vm = SubscribeOnVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Subscribe(on: )",
                           subtitle: "Introduction",
                           desc: "The subscribe operator will schedule operations to be done in the background for all upstream publishers and operators")
                
                List(vm.dataToView, id: \.self) { value in
                    Text(value)
                }
            }
            .font(.title)
            .onAppear() {
                vm.fetch()
            }
        }
    }
}


#Preview {
    SubscribeOnView()
}
