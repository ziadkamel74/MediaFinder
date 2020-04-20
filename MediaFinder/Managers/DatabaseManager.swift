//
//  File.swift
//  RegistrationApp
//
//  Created by Ziad on 4/6/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManager {
    
    static private let sharedInstance = DatabaseManager()
    var database: Connection!
    let recentSearchTable = Table("recentSearch")
    let searchText = Expression<String?>("searchText")
    let searchScope = Expression<Int?>("searchScope")
    let userId = Expression<Int>("userId")
    var Text: String?
    var scope: Int?
    
    let usersTable = Table("users")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let phone = Expression<String>("phone")
    let gender = Expression<String>("gender")
    let address = Expression<String>("address")
    let photo = Expression<Data?>("photo")
    let id = Expression<Int>("id")
    
    static func shared() -> DatabaseManager {
        return DatabaseManager.sharedInstance
    }
    
    func makeDBConnection() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("usersData").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            

        } catch {
            print(error)
        }
    }
    
    func tableExist(table: Table) -> Bool {
        
        if (try? database.scalar(table.exists)) != nil {
            return true
        }
        return false
    }
    
    func createUsersTable() {
        if !tableExist(table: usersTable) {
            do {
                let createTable = self.usersTable.create { (table) in
                    table.column(self.name)
                    table.column(self.email, unique: true)
                    table.column(self.password)
                    table.column(self.phone)
                    table.column(self.gender)
                    table.column(self.address)
                    table.column(self.photo)
                    table.column(self.id, primaryKey: true)
                    print("created")
                }
                try self.database.run(createTable)
            } catch {
                print(error)
            }
        }
        
    }
    
    func createSearchTable() {
        if !tableExist(table: recentSearchTable) {
            do {
                let createTable = self.recentSearchTable.create { (table) in
                    table.column(self.searchText)
                    table.column(self.searchScope)
                    table.column(self.userId, primaryKey: true)
                    }
                try self.database.run(createTable)
                } catch {
                    print(error)
                }
        }
    }
    
    func insertUser(_ user: User) {
        let insertUser = self.usersTable.insert(self.name <- user.name, self.email <- user.email, self.password <- user.password, self.phone <- user.phone, self.gender <- user.gender, self.address <- user.address, self.photo <- user.photo)
        do {
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
    }
    
    func insertMedia() {
            let insertMedia = self.recentSearchTable.insert(self.searchText <- nil, self.searchScope <- nil)
            do {
                try self.database.run(insertMedia)
            } catch {
                print(error)
            }
    }

    func getLastSearchTextAndScope() {
        let userId = UserDefaults.standard.object(forKey: UserDefaultsKeys.id) as? Int
        do {
            let usersSearch = try self.database.prepare(self.recentSearchTable)
            for userSearch in usersSearch {
                if userId == userSearch[self.userId] {
                    self.Text = userSearch[self.searchText]
                    self.scope = userSearch[self.searchScope]
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getUserData() -> User? {
        let userId = UserDefaults.standard.object(forKey: UserDefaultsKeys.id) as? Int
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                if userId == user[self.id] {
                   let userModel = User(name: user[self.name], email: user[self.email], password: user[self.password], phone: user[self.phone], photo: user[self.photo], gender: user[self.gender], address: user[self.address])
                    return userModel
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func validUserLogData(_ email: String, _ password: String) -> Bool {
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                let cachedEmail = user[self.email]
                let cachedPassword = user[self.password]
                let cachedId = user[self.id]
                if email == cachedEmail && password == cachedPassword {
                    UserDefaults.standard.set(cachedId, forKey: UserDefaultsKeys.id)
                    return true
                }
            }
        } catch {
            print(error)
        }
        return false
    }
    
    func updateMedia(text: String, scope: Int) {
        guard let userId = UserDefaults.standard.object(forKey: UserDefaultsKeys.id) as? Int else { return }
        do {
            let user = recentSearchTable.filter(self.userId == userId)
            
            try self.database.run(user.update(self.searchText <- text, self.searchScope <- scope))
        } catch {
            print(error)
        }
    }
    
}
