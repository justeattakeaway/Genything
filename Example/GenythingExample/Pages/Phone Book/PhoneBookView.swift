import Genything
import SwiftUI
import Trickery

// MARK: - Contact

private struct Contact: Identifiable {
    let id: UUID = .init()
    let name: String
    let phoneNumber: String
}

// MARK: - PhoneBookCell

private struct PhoneBookCell: View {
    let contact: Contact

    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name)
                .font(.title)
            Text(contact.phoneNumber)
                .font(.subheadline)
        }
    }
}

// MARK: - PhoneBookView

struct PhoneBookView: View {
    private let data = Generators.zip(Fake.PersonNames.full(), Fake.PhoneNumbers.formatted) {
        Contact(name: $0, phoneNumber: $1)
    }.take(50, randomSource: .random())

    var body: some View {
        List {
            ForEach(data) { contact in
                PhoneBookCell(contact: contact)
            }
        }
        .navigationTitle("Contacts")
    }
}

// MARK: - PhoneBookView_Previews

struct PhoneBookView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneBookView()
    }
}
