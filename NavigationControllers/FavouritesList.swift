import Foundation
import UIKit

class FavouritesList{
    
    
    static let sharedFavouritesList = FavouritesList()
    private(set) var favourites:[String]
    
    //Constructor
    init(){
        
        let defaults = UserDefaults.standard
        
        let storedFavourites = defaults.object(forKey: "favourites") as? [String]
        
        favourites = storedFavourites != nil ? storedFavourites! : []
        
    }
    
    
    //This method add fonts to the user preference files.
    func addFavourites(fontName:String){
        
        if !favourites.contains(fontName){
            favourites.append(fontName)
            saveFavourites()
        }
        
    }
    
    //This method saves the font favourites to user preference file
    private func saveFavourites(){
        
        let defaults = UserDefaults.standard
        defaults.set(favourites, forKey: "favourites")
        defaults.synchronize()
        
    }
    
    
    //this method removes a favourite from user prefernce file
    func removeFavourites(fontName: String){
        
        if let index = favourites.index(of: fontName){
            
            favourites.remove(at: index)
            
            saveFavourites()
        }
        
    }
    
    
    
}
