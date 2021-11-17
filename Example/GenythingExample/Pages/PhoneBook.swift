import SwiftUI
import Trickery
import Genything

struct Contact: Identifiable {
    let id: UUID = UUID()
    let name: String
    let phoneNumber: String
}

struct PhoneBookCell: View {
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
struct PhoneBook: View {
    let data = Gen.zip(Fake.Names.full, Fake.PhoneNumbers.formatted) {Contact(name: $0, phoneNumber: $1)}.samples(count: 50)
    
    var body: some View {
        List {
            ForEach(data){ contact in
                PhoneBookCell(contact: contact)
            }
        }
        .navigationTitle("Contacts")
    }
}

struct PhoneBook_Previews: PreviewProvider {
    static var previews: some View {
        PhoneBook()
    }
}


