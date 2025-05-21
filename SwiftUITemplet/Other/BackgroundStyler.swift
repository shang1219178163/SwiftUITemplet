//
//  BackgroundStyler.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/28.
//


actor BackgroundStyler {
    // another actor-isolated type
    private let store = StyleStore()


    deinit {
        // no actor isolation here, so none will be inherited by the task
        Task { [store] in
            await store.stopNotifications()
        }
    }
}


@MainActor
class StyleStore {

    func stopNotifications() -> Void {
        // TODO: stopNotifications
    }
}
