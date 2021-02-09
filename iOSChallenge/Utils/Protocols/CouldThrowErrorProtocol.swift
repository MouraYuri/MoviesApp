//
//  CouldThrowErrorProtocol.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 20/01/21.
//

import Foundation

protocol CouldThrowErrorProtocol: class {
    func didFinishWithError(_ error: Error)
}
