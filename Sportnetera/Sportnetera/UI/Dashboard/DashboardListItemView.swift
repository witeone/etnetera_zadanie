//
//  DashboardListItemView.swift
//  Sportnetera
//
//  Created by Marek Polak on 09/11/2024.
//

import SwiftUI

struct DashboardListItemView: View {
    var isRemote: Bool
    var title: String
    var date: String
    var body: some View {
        HStack {
            Circle()
                .frame(width: 10, height: 10)
                .foregroundStyle(isRemote ? .green : .yellow)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)

                Text(date)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    DashboardListItemView(isRemote: false, title: "name", date: Date().formatted())
}
