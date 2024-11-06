import SwiftUI

struct AppPreview: Identifiable {
    let name: String
    var id: String { name }
    
}

struct AppPreviews: View {
    private let columns = Array(repeating: GridItem(.fixed(44), spacing: 14), count: 5)
    
    var body: some View {
        Panel {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 14) {
                ForEach([AppPreview(name: "App")]) { app in
                    Button {
                        //                            didSelect(app: app, index: index)
                    } label: {
                        AppPreviewTile()
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding([.top, .horizontal], 16)
            .padding(.bottom, 12)
        }
//        .padding([.top, .horizontal], 16)
//        .padding(.bottom, 12)
    }
}
