//
//  TeamTableViewController.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 28.05.2022.
//

import UIKit

class TeamTableViewController: UITableViewController {
    private let teamManager = TeamManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamManager.team.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! PersonCell
        
        cell.configure(person: teamManager.team[indexPath.row])

        return cell
    }
}
