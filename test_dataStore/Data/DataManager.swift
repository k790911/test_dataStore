//
//  DataManager.swift
//  test_dataStore
//
//  Created by 김재훈 on 2022/01/13.
//

import Foundation
import CoreData

class DataManager {
    
    // 공유 인스턴스 저장할 타입 인스턴스
    static let shared = DataManager()
    
    // 메모를 저장할 배열을 만들고 빈배열로 초기화
    var memoList = [Memo]()
    
    private init() {
        
    }
    
    // 컨텍스트 객체가 코어데이터에서 대부분의 작업을 담당
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 데이터베이스에서 데이터를 읽어옴. fetch
    func fetchMemo() {
        // 읽어올때는 먼저 페치 리퀘스트를 만들어야 함
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        // 날짜로 정렬
        //let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        //request.sortDescriptors = [sortByDateDesc]
        
        // 페치리퀘스트를 사용할 때는 컨텍스트 객체가 제공하는 페치 매소드를 사용해야 함
        do {
            // 데이터베이스에 저장된 메모가 날짜로 정렬 된 후메모리스트 배열에 저장됨, 읽어오는 코드는 완성
            memoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func addNewMemo(_ memo: String?) {
        // 코어데이터가 만든 클래스 이므로, 새로운 데이터를 만들때 컨텍스트를 전달해야함.
        let newMemo = Memo(context: mainContext) // 데이터베이스 메모 저장을 위한 비어있는 인스턴스가 생성됨
        newMemo.title = memo
        
        // 새로운 메모 인스턴스를 생성했다고 해서 메모가 데이터베이스에 저장되는 것이 아님, 실제로 데이터베이스에 저장하려면 컨텍스트를 저장해야함. 
        saveContext()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "test_dataStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
