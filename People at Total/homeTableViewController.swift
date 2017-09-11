//
//  homeTableViewController.swift
//  People at Total
//
//  Created by Florian Letellier on 31/01/2017.
//  Copyright © 2017 Florian Letellier. All rights reserved.
//

import UIKit


class homeTableViewController: UITableViewController {

    var users:[User] = []
    var profiles:[Profile] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProfile" {
            let profileVC = segue.destination as? profileViewController
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            profileVC?.profile = profiles[indexPath.row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user1 = User()
        let user2 = User()
        let user3 = User()
        let user4 = User()
        let user5 = User()
        
        /*user1.name = "Gregori Fabre"
        user1.job = "Digital Advisor"
        user1.location = "Coupole, 12E41"
        user1.image = "gregori"
        user1.entities = "EP/SCR/TF-DIGITAL"
        
        user2.name = "Virginie fromaget"
        user2.job = "Performance and Innovation Manager"
        user2.location = "Michelet 1735"
        user2.image = "virginie"
        user2.entities = "MS/RH/GC"
        
        user3.name = "Alexandre Boissy"
        user3.job = "Innovation"
        user3.location = "Paris"
        user3.image = "alexandre"
        user3.entities = "EP/SCR/TF-DIGITAL"
        
        user4.name = "Marion Delbos"
        user4.job = "Responsable Com Digitalisation & Innovation"
        user4.location = "Paris"
        user4.image = "marion"
        user4.entities = "EP/SCR/TF-DIGITAL"
        
        user5.name = "Pierre de Milly"
        user5.job = "Schoolab consultant"
        user5.location = "Paris"
        user5.image = "pierre"
        user5.entities = "EP/SCR/TF-DIGITAL"
        
        users = [user1, user2, user3, user4, user5]
        
        // création des jobs
        var jobs: [Job] = []
        let job1 = Job()
        job1.title = "Digital advisor E&P"
        job1.company = "Total"
        job1.start_date = "From May 2016"
        job1.description = "Advisor for digital initiatives in subsurface"
        job1.location = "Tour Coupole, Paris"
        
        let job2 = Job()
        job2.title = "Exploration Geoscientist"
        job2.company = "Total"
        job2.start_date = "September 2014 - May 2016"
        job2.description = "New ventures Azerbaidjan & Mexico exploration"
        job2.location = "Tour Coupole, Paris"
        
        
        let job3 = Job()
        job3.title = "Performance and Innovation Manager"
        job3.start_date = "From September 2016"
        job3.description = "Innovation and Performance project manager for Career Managers Team in MS Branch"
        job3.location = "Michelet 1735"
        
        let job4 = Job()
        job4.title = "Gestionnaire de Carrières"
        job4.start_date = "From July 2012 to August 2016"
        job4.description = "En charge de la population OETAM de Michelet + stations d'aviation + dépôts pétroliers en France"
        
        let job5 = Job()
        job5.title = "Responsable du Service Clients GR"
        job5.start_date = "From October 2008 to June 2011"
        job5.location = "Spazio"
        job5.description = "Responsable du service clients GR + responsable Qualité + en charge du suivi des fraudes et pertes/profits"
        
        let job6 = Job()
        job6.title = "Chef de Secteur Cartes GR"
        job6.start_date = "From October 2005 to September 2008"
        job6.location = "Lyon"
        job6.description = "En charge du développement commercial des cartes GR sur le département du Rhône"
        
        
        jobs = [job1, job2]
        
        var projects: [Project] = []
        let project1 = Project()
        project1.title = "Just One Total"
        project1.start_date = "From May 2016"
        project1.location = "Paris, France"
        project1.members = [2, 3]
        project1.description = "Sponsor for People (PIE) project"
        
        let project2 = Project()
        project2.title = "Benchmark visio conferencing tools"
        project2.start_date = "February 2015 - July 2015"
        project2.description = "In-house interpretation plateform"
        project2.location = "CSTJF, Pau"
        project2.members = [1, 3]
        
        let project3 = Project()
        project3.title = "ATLAS"
        project3.start_date = "From March 2010 to June 2012"
        project3.location = "Spazio"
        project3.members = [4, 5]
        
        projects = [project1, project2]
        
        var relations: Relation = Relation()
        relations.managers = [1]
        relations.colleagues = [2]
        relations.assistant = [3]
        relations.teamMember = [4]
        
        
        
        var profile1 = Profile()
        profile1.user = user1
        profile1.jobs = jobs
        profile1.projects = projects
        profile1.relations = relations
        
        var profile2 = Profile()
        profile2.user = user2
        profile2.jobs = [job3, job4]
        profile2.projects = [project3]
        profile2.relations = relations
        
        
        
        profiles = [profile1, profile2, profile1, profile2, profile1]*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         return 1
    }

     func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 38)!
        header.textLabel?.textColor = UIColor.lightGray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "PEOPLE YOU MAY KNOW"
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileTableViewCell

        // Configure the cell...
        let row = indexPath.row
        cell.nameLabel?.text = "\(users[row].first_name!) \(users[row].last_name!)"
        //cell.avatarImageView?.image = UIImage(named: users[row].image!)
        cell.jobTitleLabel?.text = "\(users[row].job!) \(users[row].entities!)"
        
        return cell
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
