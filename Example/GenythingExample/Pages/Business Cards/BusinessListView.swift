import Genything
import SFSafeSymbols
import SwiftUI
import Trickery

// MARK: - BusinessCard

struct BusinessCard: Identifiable {
    let id: UUID = .init()
    let name: String
    let email: String
    let symbolName: SFSymbol
    let addressLine1: String
    let addressLine2: String
}

// MARK: - BusinessListCell

struct BusinessListCell: View {
    let businessCard: BusinessCard

    var body: some View {
        HStack(alignment: .top) {
            Image(systemSymbol: businessCard.symbolName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.orange)
                .padding()

            VStack(alignment: .leading, spacing: 5) {
                Text(businessCard.name)
                    .font(.title)
                    .foregroundColor(.orange)
                Text(businessCard.email)
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(businessCard.addressLine1)
                        .font(.subheadline)
                    Text(businessCard.addressLine2)
                        .font(.subheadline)
                }
            }
            Spacer()
        }
    }
}

// MARK: - BusinessListView

struct BusinessListView: View {
    let data = AnyGenerator<BusinessCard> { rs in
        let addressLine2Gen = Generators.one(of: [
            Fake.Addresses.caLastLine,
            Fake.Addresses.usLastLine,
        ])

        let name = Fake.BusinessNames.any.next(rs)

        return BusinessCard(
            name: name,
            email: Fake.Emails.business(name).next(rs),
            symbolName: .arbitrary.next(rs),
            addressLine1: Fake.Addresses.streetLine.next(rs),
            addressLine2: addressLine2Gen.next(rs)
        )
    }.take(50, randomSource: .predetermined())

    var body: some View {
        List {
            ForEach(data) { businessCard in
                BusinessListCell(businessCard: businessCard)
            }
        }
        .navigationTitle("Business Cards")
    }
}

// MARK: - BusinessListView_Previews

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessListView()
    }
}
