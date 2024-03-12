//
//  MergeView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/12/24.
//

import SwiftUI

struct MergeView: View {
    @StateObject private var vm = Merge()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Merge",
                           subtitle: "Introduction",
                           desc: "The merge operator can collect items of the same type from many different  publishers and send them all down the same pipeline.")
               
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
    MergeView()
}
