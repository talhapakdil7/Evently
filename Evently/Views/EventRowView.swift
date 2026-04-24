import SwiftUI

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: event.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                    }
            }
            .frame(width: 64, height: 64)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(event.name)
                    .font(.subheadline.bold())
                    .lineLimit(2)
                
                if let date = event.dates?.start?.localDate {
                    Text(date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(.background.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
