//
//  CallHistoryCallEventTargetTests.swift
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

import UseCases
import UseCasesTestDoubles
import XCTest

final class CallHistoryCallEventTargetTests: XCTestCase {
    func testAddsRecordToCallHistoryOnCallDisconnect() {
        let account = SimpleAccount(uuid: "any-id", domain: "any-domain")
        let histories = DefaultCallHistories(factory: CallHistoryFactoryStub(history: TruncatingCallHistory()))
        histories.didAdd(account, to: UserAgentSpy())
        let sut = CallHistoryCallEventTarget(histories: histories)
        let call = SimpleCall(
            account: account,
            remote: URI(user: "any-user", host: "any-host"),
            date: Date(),
            duration: 60,
            isIncoming: false,
            isMissed: false
        )

        sut.callDidDisconnect(call)

        XCTAssertEqual(histories.history(forAccountWithID: call.account.uuid).allRecords, [CallHistoryRecord(call: call)])
    }
}
