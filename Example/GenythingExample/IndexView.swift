import SwiftUI
import Trickery

private enum Destination: String, CaseIterable, Identifiable {
    case phoneBook
    case businessList
    
    var id: String {
        rawValue
    }
    
    var title: String {
        rawValue.capitalized
    }
}

struct IndexView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Destination.allCases) { destination in
                    NavigationLink(destination: {
                        switch destination {
                            case .phoneBook: PhoneBook()
                            case .businessList: BusinessListView()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
