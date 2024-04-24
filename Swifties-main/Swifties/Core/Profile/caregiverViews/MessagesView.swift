//
//  MessagesView.swift
//  Swifties
//
//  Created by Pavneet Cheema on 4/17/24.
//

//
//  MessagesView.swift
//  Swifties
//
//  Created by J's on 3/22/24.
//

import SwiftUI

    struct Message: Identifiable {
        var id = UUID()
        var sender: String
        var text: String
        var timestamp: Date
    }

    struct MessagesView: View {
        let messages: [Message] = [
            Message(sender: "John", text: "*****8132", timestamp: Date()),
            Message(sender: "Alice", text: "SNN identified", timestamp: Date()),
            Message(sender: "Bob", text: "private info shared", timestamp: Date())
        ]
        
        var body: some View {
            NavigationView {
                List(messages) { message in
                    MessageRow(message: message)
                }
                .navigationTitle("Notifications")
            }
        }
    }

    struct MessageRow: View {
        var message: Message
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(message.sender)
                    .font(.headline)
                Text(message.text)
                    .font(.body)
                    .foregroundColor(.secondary)
                Text(message.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(10)
        }
    }

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
//#Preview {
//    MessagesView()
//}
#Preview {
    MessagesView()
}
