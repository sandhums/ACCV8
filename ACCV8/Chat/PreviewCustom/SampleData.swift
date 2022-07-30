//
//  SampleData.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 01/07/22.
//

import RealmSwift
import UIKit

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
    static var samples: [Item] { get }
}

extension Date {
    static var random: Date {
        Date(timeIntervalSince1970: (50 * 365 * 24 * 3600 + Double.random(in: 0..<(3600 * 24 * 365))))
    }
}
//extension Centre {
//    convenience init(photoName: String) {
//        self.init()
//        self.centreImage = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
//        self.centreBackground = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
//        self.centreLogo = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
//    }
//    convenience init(_ centre: Centre) {
//        self.init()
//        
//        self.centreImage = centre.centreImage
//        self.centreBackground = centre.centreBackground
//        self.centreLogo = centre.centreLogo
//        
//    }
//}
//extension Centre: Samplable {
//    static var samples: [Centre] { [sample] }
//    static var sample: Centre {
//        Centre(centreName: "Ranchi", centreDesc: "Artemis Heart Centre at Raj Hospital", centreIndex: 1, centreText: "placeholder text", centreImage: Centre(photoName: "Illustration 3"), centreBackground: Centre(photoName: "Background 4"), centreLogo: Centre(photoName: "Logo1"))
//    }
//}
extension Reps {
    convenience init(username: String, firstName: String, lastName: String, designation: String, userBio: String, userIndex: Int, userMobile: String, centreName: String, presence: Presence, userPreferences: UserPreferences, conversations: [Conversation]) {
        self.init()
        self.userName = username
        self.firstName = firstName
        self.lastName = lastName
        self.designation = designation
        self.userBio = userBio
        self.userIndex = userIndex
        self.userMobile = userMobile
        self.centreName = centreName
        self.presence = presence.asString
        self.userPreferences = userPreferences
        self.lastSeenAt = Date.random
        conversations.forEach { conversation in
            self.conversations.append(conversation)
        }
    }
    
    convenience init(_ user: Reps) {
        self.init()
        userName = user.userName
        firstName = user.firstName
        lastName = user.lastName
        designation = user.designation
        userBio = user.userBio
        userIndex = user.userIndex
        userMobile = user.userMobile
        centreName = user.centreName
        userPreferences = UserPreferences(user.userPreferences)
        lastSeenAt = user.lastSeenAt
        conversations.append(objectsIn: user.conversations.map { Conversation($0) })
        presence = user.presence
    }
}

extension Reps: Samplable {
    static var samples: [Reps] { [sample, sample2, sample3] }
    static var sample: Reps {
        Reps(username: "999@999.com", firstName: "Nico", lastName: "Sandhu", designation: "Consultant", userBio: "He he he..", userIndex: 1, userMobile: "9999999999", centreName: "Head Office", presence: .onLine, userPreferences: .sample, conversations: [.sample, .sample2, .sample3])
    }
    static var sample2: Reps {
        Reps(username: "888@888.com", firstName: "Milo", lastName: "Sandhu", designation: "Consultant", userBio: "He he he..", userIndex: 1, userMobile: "888888888", centreName: "Panipat", presence: .offLine, userPreferences: .sample2, conversations: [.sample, .sample2])
    }
    static var sample3: Reps {
        Reps(username: "777@777.com", firstName: "Zoey", lastName: "Sandhu", designation: "Technician", userBio: "He he he..", userIndex: 1, userMobile: "7777777777", centreName: "Ranchi", presence: .hidden, userPreferences: .sample3, conversations: [.sample, .sample3])
    }
}

extension UserPreferences {
    convenience init(displayName: String, photo: Photo) {
        self.init()
        self.displayName = displayName
        self.avatarImage = photo
    }
    
    convenience init(_ userPreferences: UserPreferences?) {
        self.init()
        if let userPreferences = userPreferences {
            displayName = userPreferences.displayName
            avatarImage = Photo(userPreferences.avatarImage)
        }
    }
}

extension UserPreferences: Samplable {
    static var samples: [UserPreferences] { [sample, sample2, sample3] }
    static var sample = UserPreferences(displayName: "Kilroy", photo: .sample)
    static var sample2 = UserPreferences(displayName: "IronMan", photo: .sample2)
    static var sample3 = UserPreferences(displayName: "Jim Morrison", photo: .sample3)
}

extension Conversation {
    convenience init(displayName: String, unreadCount: Int, members: [Member]) {
        self.init()
        self.displayName = displayName
        self.unreadCount = unreadCount
        self.members.append(objectsIn: members.map { Member($0) })
        
//        forEach { username in
//            self.members.append(Member(username))
//        }
    }
    
    convenience init(_ conversation: Conversation) {
        self.init()
        displayName = conversation.displayName
        unreadCount = conversation.unreadCount
        members.append(objectsIn: conversation.members.map { Member($0) })
    }
}

extension Conversation: Samplable {
    static var samples: [Conversation] { [sample, sample2, sample3] }
    static var sample: Conversation {
        Conversation(displayName: "Test chat", unreadCount: 2, members: Member.samples)
    }
    static var sample2: Conversation {
        Conversation(displayName: "Cool chat", unreadCount: 0, members: Member.samples)
    }
    static var sample3: Conversation {
        Conversation(displayName: "Hot chat", unreadCount: 1, members: Member.samples)
    }
}

extension Member {
    convenience init(_ member: Member) {
        self.init()
        userName = member.userName
        membershipStatus = member.membershipStatus
    }
}

extension Member: Samplable {
    static var samples: [Member] { [sample, sample2, sample3] }
    static var sample: Member {
        Member(userName: "999@999.com", state: .active)
    }
    static var sample2: Member {
        Member(userName: "888@888.com", state: .active)
    }
    static var sample3: Member {
        Member(userName: "777@777.com", state: .pending)
    }
}

extension Chatster {
    convenience init(user: Reps) {
        self.init()
        self._id = user._id
        self.userName = user.userName
        self.displayName = user.userPreferences!.displayName
        self.avatarImage = Photo(user.userPreferences?.avatarImage)
        lastSeenAt = Date.random
        self.presence = user.presence
    }
    
    convenience init(_ chatster: Chatster) {
        self.init()
        userName = chatster.userName
        displayName = chatster.displayName
        avatarImage = Photo(chatster.avatarImage)
        lastSeenAt = chatster.lastSeenAt
        presence = chatster.presence
    }
}

extension Chatster: Samplable {
    static var samples: [Chatster] { [sample, sample2, sample3] }
    static var sample: Chatster { Chatster(user: Reps(.sample)) }
    static var sample2: Chatster { Chatster(user: Reps(.sample2)) }
    static var sample3: Chatster { Chatster(user: Reps(.sample3)) }
}

extension Model: Samplable {
    static var samples: [Model] { [sample, sample2, sample3] }
    static var sample: Model { Model() }
    static var sample2: Model { Model() }
    static var sample3: Model { Model() }
}

extension Photo {
    convenience init(photoName: String) {
        self.init()
        self.thumbNail = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.picture = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.date = Date.random
    }
    convenience init(_ photo: Photo?) {
        self.init()
        if let photo = photo {
            self.thumbNail = photo.thumbNail
            self.picture = photo.picture
            self.date = photo.date
        }
    }
}

extension Photo: Samplable {
    static var samples: [Photo] { [sample, sample2, sample3]}
    static var sample: Photo { Photo(photoName: "rod") }
    static var sample2: Photo { Photo(photoName: "jane") }
    static var sample3: Photo { Photo(photoName: "freddy") }
    static var spud: Photo { Photo(photoName: "spud\(Int.random(in: 1...8))") }
}

extension ChatMessage {
    convenience init(conversation: Conversation,
                     author: Reps,
                     text: String = "This is the text for the message",
                     includePhoto: Bool = false,
                     includeLocation: Bool = false) {
        self.init()
        conversationID = conversation.id
        self.author = author.userName
        self.text = text
        if includePhoto { self.image = Photo.spud }
        self.timestamp = Date.random
        if includeLocation {
            self.location.append(-0.10689139236939127 + Double.random(in: -10..<10))
            self.location.append(51.506520923981554 + Double.random(in: -10..<10))
        }
    }
    
    convenience init(_ chatMessage: ChatMessage) {
        self.init()
        conversationID = chatMessage.conversationID
        author = chatMessage.author
        text = chatMessage.text
        image = Photo(chatMessage.image)
        location.append(objectsIn: chatMessage.location)
        timestamp = chatMessage.timestamp
    }
}

extension ChatMessage: Samplable {
    static var samples: [ChatMessage] { [sample, sample2, sample3, sample20, sample22, sample23, sample30, sample32, sample33] }
    static var sample: ChatMessage { ChatMessage(conversation: .sample, author: .sample) }
    static var sample2: ChatMessage { ChatMessage(conversation: .sample, author: .sample2, includePhoto: true) }
    static var sample3: ChatMessage { ChatMessage(conversation: .sample, author: .sample3, text: "Thoughts on this **spud**?", includePhoto: true, includeLocation: true)}
    static var sample20: ChatMessage { ChatMessage(conversation: .sample2, author: .sample) }
    static var sample22: ChatMessage { ChatMessage(conversation: .sample2, author: .sample2, includePhoto: true) }
    static var sample23: ChatMessage { ChatMessage(conversation: .sample2, author: .sample3, text: "Fancy trying this?", includePhoto: true, includeLocation: true)}
    static var sample30: ChatMessage { ChatMessage(conversation: .sample3, author: .sample) }
    static var sample32: ChatMessage { ChatMessage(conversation: .sample3, author: .sample2, includePhoto: true) }
    static var sample33: ChatMessage { ChatMessage(conversation: .sample3, author: .sample3, text: "Is this a bit controversial? If nothing else, this is a very long, tedious post - I just hope that there's space for it all to fit in", includePhoto: true, includeLocation: true)}
}

extension Realm: Samplable {
    static var samples: [Realm] { [sample] }
    static var sample: Realm {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            Reps.samples.forEach { user in
                realm.add(user)
            }
            Chatster.samples.forEach { chatster in
                realm.add(chatster)
            }
            ChatMessage.samples.forEach { message in
                realm.add(message)
            }
        }
        return realm
    }
    
    static func bootstrap() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                realm.add(Chatster.samples)
                realm.add(Reps(Reps.sample))
                realm.add(ChatMessage.samples)
            }
        } catch {
            print("Failed to bootstrap the default realm")
        }
    }
}
