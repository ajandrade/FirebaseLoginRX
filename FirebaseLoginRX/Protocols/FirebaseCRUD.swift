//
//  FirebaseCRUD.swift
//  FirebaseLoginRX
//
//  Created by Amadeu Andrade on 15/10/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Firebase
import RxSwift

protocol FirebaseCRUD { }

extension FirebaseCRUD {
  
  /** Database root's reference. */
  var rootReference: DatabaseReference {
    return Database.database().reference()
  }
  
  /** Gets all elements of a given reference.
   - parameter reference: Reference from Firebase's table
   - returns: An observable containing the element's snapshot data.
   */
  func getAll(from reference: DatabaseReference) -> Observable<DataSnapshot> {
    return Observable.create { observer in
      reference.observeSingleEvent(of: .value, with: { snapshot in
        observer.onNext(snapshot)
        observer.onCompleted()
      }, withCancel: { _ in
        observer.onCompleted()
      })
      return Disposables.create()
    }
  }
  
  /** Gets the element from a given reference that matches a specified key.
   - parameters:
   - key: the object's key.
   - reference: Reference from Firebase's table.
   - returns: An observable containing the element's snapshot data.
   */
  func get(objectWithKey key: String, from reference: DatabaseReference) -> Observable<DataSnapshot> {
    return Observable.create { observer in
      reference.child(key).observeSingleEvent(of: .value, with: { snapshot in
        observer.onNext(snapshot)
        observer.onCompleted()
      }, withCancel: { _ in
        observer.onCompleted()
      })
      return Disposables.create()
    }
  }
  
  /** Inserts a new item on a given reference.
   - parameters:
   - data: The item's data.
   - reference: Reference from Firebase's table.
   - returns: An empty observable.
   */
  func insert(data: [String: Any], at reference: DatabaseReference) -> Observable<Void> {
    return Observable.create { observer in
      reference.setValue(data, withCompletionBlock: { error, snapshot in
        if let error = error {
          observer.onError(error)
        } else {
          observer.onNext()
          observer.onCompleted()
        }
      })
      return Disposables.create()
    }
  }
  
  /** Updates a item on a given reference.
   - parameters:
   - data: The item's data.
   - reference: Reference from Firebase's table.
   - returns: An empty observable.
   */
  func update(data: [String: Any], on reference: DatabaseReference) -> Observable<Void> {
    return Observable.create { observer in
      reference.updateChildValues(data, withCompletionBlock: { error, snapshot in
        if let error = error {
          observer.onError(error)
        } else {
          observer.onNext()
          observer.onCompleted()
        }
      })
      return Disposables.create()
    }
  }
  
  /** Sets a listener on a given reference.
   - parameters:
   - reference: Reference from Firebase's table.
   - returns: An observable containing the element's snapshot data.
   */
  func listen(reference: DatabaseReference) -> Observable<DataSnapshot>  {
    return Observable.create { observer in
      let handle = reference.observe(.value, with: { snapshot in
        observer.onNext(snapshot)
      })
      return Disposables.create {
        reference.removeObserver(withHandle: handle)
      }
    }
  }
  
  /** Deletes all data on a given reference.
   - parameters:
   - reference: Reference from Firebase's table.
   - returns: An empty observable.
   */
  func delete(reference: DatabaseReference) -> Observable<Void> {
    return Observable.create { observer in
      reference.removeValue(completionBlock: { error, snapshot in
        if let error = error {
          observer.onError(error)
        } else {
          observer.onNext()
          observer.onCompleted()
        }
      })
      return Disposables.create()
    }
  }
  
}
