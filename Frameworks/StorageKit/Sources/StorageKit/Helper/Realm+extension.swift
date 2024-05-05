//
//  Realm+extension.swift
//
//
//  Created by Khalid on 04/05/2024.
//

import Foundation
import RealmSwift

extension Realm {
    /// Asynchronously writes a collection of thread-confined objects to the Realm.
    ///
    /// - Parameters:
    ///   - passedObject: The collection of objects to be written to the Realm.
    ///   - errorHandler: The error handler called if an error occurs during the write operation. Defaults to a closure that does nothing.
    ///   - block: The block to execute within the write transaction. It provides the Realm and the collection of objects to be written.
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

    /// Asynchronously writes a single thread-confined object to the Realm.
    ///
    /// - Parameters:
    ///   - passedObject: The object to be written to the Realm.
    ///   - errorHandler: The error handler called if an error occurs during the write operation. Defaults to a closure that does nothing.
    ///   - block: The block to execute within the write transaction. It provides the Realm and the object to be written.
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
