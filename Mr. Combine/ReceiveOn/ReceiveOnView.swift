//
//  ReceieveOnView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/9/24.
//

import SwiftUI

struct ReceiveOnView: View {
    @StateObject private var vm = ReceiveOnVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Receive(on: )",
                           subtitle: "Introduction",
                           desc: "The receive operator will move items coming down the pipeline to another pipeline (thread).")
                
                Button("Get Data from internet") {
                    vm.fetch()
                }
                
                vm.imageView
                    .resizable()
                    .scaledToFit()
                
                Spacer(minLength: 0)
            }
            .font(.title)
        }
    }
}


#Preview {
    ReceiveOnView()
}
