//
//  FavoritosViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 12/11/20.
//

import UIKit
import CoreData


class FavoritosViewController: UIViewController, NSFetchedResultsControllerDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewFavoritos: UITableView!
    
    
    // MARK: Variáveis
    
    var arrayMed = [Remedio] ()
    var favoriteManager: NSFetchedResultsController<Favorite>?
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recoverDrugs()
        
                
        tableViewFavoritos.delegate = self
        tableViewFavoritos.dataSource = self

        
        tableViewFavoritos.reloadData()
    }
    
    // MARK: Métodos
   
    
    func recoverDrugs() {
        let sourchFavorite: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let order = NSSortDescriptor(key: "drugsFavorite", ascending: true)
        sourchFavorite.sortDescriptors = [order]
        
        
        favoriteManager = NSFetchedResultsController(fetchRequest: sourchFavorite, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        favoriteManager?.delegate = self
        
        do {
            try favoriteManager?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func reloadData() {
        tableViewFavoritos.reloadData()
    }
}

    // MARK: Extensions TableView
extension FavoritosViewController: UITableViewDelegate {
    
}
extension FavoritosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listDrugs = favoriteManager?.fetchedObjects?.count
        else { return 0 }
        
        return listDrugs
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalheMedicamentoTableViewCell", for: indexPath) as! DetalheMedicamentoTableViewCell
        //cell.setup(details: arrayMed[indexPath.row])
        guard let drugs = favoriteManager?.fetchedObjects?[indexPath.row] else { return cell }
        
        cell.labelProductName.text = drugs.drugsFavorite
        //cell.labelLaboratoryName.text = drugs.drugLab
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let selectDrug = favoriteManager?.fetchedObjects?[indexPath.row] else { return }
            context.delete(selectDrug)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    // MARK: Fetched Results ControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
            case .delete:
                guard let indexPath = indexPath else { return }
                tableViewFavoritos.deleteRows(at: [indexPath], with: .fade)
                break
            default:
                tableViewFavoritos.reloadData()
            }
    }
    
    
    
}

