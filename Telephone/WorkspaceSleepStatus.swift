//
//  WorkspaceSleepStatus.swift
//  Telephone
//
//  Copyright (c) 2008-2016 Alexey Kuznetsov
//  Copyright (c) 2016 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import AppKit

final class WorkspaceSleepStatus: NSObject {
    private(set) var isSleeping = false

    private let workspace: NSWorkspace

    init(workspace: NSWorkspace) {
        self.workspace = workspace
        super.init()
        let nc = workspace.notificationCenter
        nc.addObserver(self, selector: #selector(willSleep), name: .NSWorkspaceWillSleep, object: workspace)
        nc.addObserver(self, selector: #selector(didWake), name: .NSWorkspaceDidWake, object: workspace)
    }

    deinit {
        workspace.notificationCenter.removeObserver(self, name: .NSWorkspaceWillSleep, object: workspace)
        workspace.notificationCenter.removeObserver(self, name: .NSWorkspaceDidWake, object: workspace)
    }

    @objc private func willSleep(notification: Notification) {
        isSleeping = true
    }

    @objc private func didWake(notification: Notification) {
        isSleeping = false
    }
}
