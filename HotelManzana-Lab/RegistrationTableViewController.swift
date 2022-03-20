//
//  RegistrationTableViewController.swift
//  HotelManzana-Lab
//
//  Created by Jadson on 15/03/22.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var registrations: [Registration] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return registrations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        let registrations = registrations[indexPath.row]
        //use DateFormatter to use the short version of the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.textLabel?.text = registrations.firstName + " " + registrations.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registrations.checkInDate) + " - " + dateFormatter.string(from: registrations.checkOutDate) + " - " + registrations.roomType.name

        return cell
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController, let registration = addRegistrationTableViewController.registration else { return }
        registrations.append(registration)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = registrations[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: details)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailsRegistrationViewController, let registration = sender as? Registration {
            destinationVC.registration = registration
        }
        
//        let destinationVC = segue.destination as? DetailsRegistrationViewController
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let details = registrations[indexPath.row]
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .short
//            destinationVC?.firstName = details.firstName
//            destinationVC?.lastName = details.lastName
//            destinationVC?.email1 = details.emailAdress
//            destinationVC?.checkInDate1 = dateFormatter.string(from: details.checkInDate)
//            destinationVC?.checkOutDate1 = dateFormatter.string(from: details.checkOutDate)
//            destinationVC?.numberOfAdults1 = String(details.numberOfAdults)
//            destinationVC?.numberOfChildren1 = String(details.numberOfChildren)
//            destinationVC?.wifi = String(details.wifi)
//            destinationVC?.roomChoice1 = details.roomType.name
//        }
    }

}
