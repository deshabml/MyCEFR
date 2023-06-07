//
//  FirestoreService.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import Foundation
import FirebaseFirestore

class FirestoreService {

    static let shared = FirestoreService()
    let db = Firestore.firestore()
    var userProfilesRef: CollectionReference { db.collection("userProfiles") }

    private init() { }

    func createProfile(userProfile: UserProfile) async throws {
        do {
            try await userProfilesRef.document(userProfile.id).setData(userProfile.representation)
        } catch {
            throw error
        }
    }

    func getProfile(userId: String) async throws -> UserProfile {
        do {
            let snap = try await userProfilesRef.document(userId).getDocument()
            guard let data = snap.data() else {
                throw FirestoreErrorCode(.dataLoss)
            }
            guard let profile = UserProfile(data: data) else {
                throw FirestoreErrorCode(.invalidArgument)
            }
            return profile
        } catch {
            throw error
        }
    }

}
