//
//  Realm+extension.swift
//
//
//  Created by Khalid on 04/05/2024.
//

import Foundation
import RealmSwift

extension Realm {
    func writeAsync<T: ThreadConfined>(
        _ passedObject: [T],
        errorHandler: @escaping ((_ error: Swift.Error?) -> Void) = { _ in },
        block: @escaping ((Realm, [T]?) -> Void)
    ) {
        let configuration = self.configuration
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: configuration)
                    realm.refresh()
                    try realm.write {
                        block(realm, passedObject)
                    }
                    errorHandler(nil)
                } catch {
                    errorHandler(error)
                }
            }
        }
    }

    func writeAsync<T: ThreadConfined>(
        _ passedObject: T,
        errorHandler: @escaping ((_ error: Swift.Error?) -> Void) = { _ in },
        block: @escaping ((Realm, T?) -> Void)
    ) {
        let objectReference = ThreadSafeReference(to: passedObject)
        let configuration = self.configuration
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: configuration)
                    realm.refresh()
                    try realm.write {
                        let object = realm.resolve(objectReference)
                        block(realm, object)
                    }
                    errorHandler(nil)
                } catch {
                    errorHandler(error)
                }
            }
        }
    }
}
