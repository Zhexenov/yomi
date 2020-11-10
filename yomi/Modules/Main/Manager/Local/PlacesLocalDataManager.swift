//
//  PlacesLocalDataManager.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import CoreData


protocol IPlacesLocalDataManager : MainDataManager {
    
    func fetchSavedPlaces() -> [Place]
    
    func savePlaces(_ list: [Place])
}


class PlacesLocalDataManager : IPlacesLocalDataManager {
    
    
    weak var handler: MainDataManagerOutput?
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "yomi")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchNearbyPlaces() {
        
    }
    
    func fetchSavedPlaces() -> [Place] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PlaceEntity>(entityName: "PlaceEntity")
        do {
            let places = try context.fetch(fetchRequest).compactMap({ (entity) -> Place in
                Place(placeId: entity.placeId!, name: entity.name!)
            })
            return places
        } catch let fetchErr {
            print(fetchErr)
            return []
        }
    }
    
    func savePlaces(_ list: [Place]) {
        let context = persistentContainer.viewContext
        for place in list {
            let placeEntity = NSEntityDescription.insertNewObject(forEntityName: "PlaceEntity", into: context)
            placeEntity.setValue(place.placeId, forKey: "placeId")
            placeEntity.setValue(place.name, forKey: "name")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    
}
