//
//  SKNotification.swift
//
//
//  Created by JH on 2023/4/14.
//

import Foundation
import SourceKittenFramework

public class SKNotification: Codable {
    // MARK: - Public Type Aliases

    public typealias NotificationKind = SKNotificationKind

    // MARK: - Public Stored Properties

    public let name: String

    public let notification: NotificationKind

    // MARK: - Public Initializers

    public init(name: String, notification: NotificationKind) {
        self.name = name
        self.notification = notification
    }

    // MARK: - Internal Declarations

    enum CodingKeys: String, CodingKey {
        case name = "key.name"
        case notification = "key.notification"
    }
}
