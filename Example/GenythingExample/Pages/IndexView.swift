import SwiftUI
import Trickery

// MARK: - Destination

private enum Destination: String, CaseIterable, Identifiable {
    case phoneBook
    case businessList
    case genLibs
    case shapeDrawing

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
            case .genLibs: return "Gen Libs"
            case .businessList: return "Business Cards"
            case .phoneBook: return "Phone Book"
            case .shapeDrawing: return "Shape Drawing"
        }
    }
}

// MARK: - IndexView

struct IndexView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Destination.allCases) { destination in
                    NavigationLink(destination: {
                        switch destination {
                            case .phoneBook: PhoneBookView()
                            case .businessList: BusinessListView()
                            case .genLibs: GenLibsView()
                            case .shapeDrawing: ShapeDrawingView()
                        }
                    }) {
                        Text(destination.title)
                    }
                }
            }
            .navigationTitle("Examples")
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
