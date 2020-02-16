//
//  Redux.swift
//  DarkModeSwitchRedux
//
//  Created by YupinHuPro on 2/16/20.
//  Copyright © 2020 YupinHuPro. All rights reserved.
//

import Foundation

// MARK: Usually implemted by the app delegate

protocol Reduxable {
    var store: Store? { get set }
}

// MARK: State

typealias State = Dictionary<String, Any>

// MAKR: Actions

protocol ActionType {
    var type: String { get }
    var data: Any { get }
}

struct InitialAction: ActionType {
    var type: String
    var data: Any { get { return "" } }
    init() {
        self.type = "Initial"
    }
}

// MARK: Subscriber

protocol Subscriber {
    func update(_ state: State)
    var identifier: String { get set }
}

func generateIdentitifer() -> String {
    return UUID().uuidString
}

func !=(lhs: Subscriber, rhs: Subscriber) -> Bool {
    return lhs.identifier != rhs.identifier
}

// MARK: Store

protocol Reducable {
    var reducer: (_ state: State?, _ action: ActionType) -> State? { get }
}

// Simple redux store implementation

struct Store: Reducable {
    var state: State?
    var reducer: (_ state: State?, _ action: ActionType) -> State?
    var subscribers: Array<Subscriber>

    init(reducer: @escaping (State?, ActionType) -> State?) {
        self.reducer = reducer
        self.state = reducer(nil, InitialAction())
        self.subscribers = []
    }

    mutating func dispatch(_ action: ActionType) {
        self.state = self.reducer(self.state, action)
        if let state = self.state {
            self.subscribers.forEach { $0.update(state) }
        }
    }

    mutating func subscribe(_ listner: Subscriber) {
        self.subscribers.append(listner)
    }

    mutating func unsubscribe(_ listner: Subscriber) {
        self.subscribers = self.subscribers.filter({ $0 != listner })
    }
}
