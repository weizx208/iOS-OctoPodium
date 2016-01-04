//
//  UsersSearchController.swift
//  GitHubAwards
//
//  Created by Nuno Gonçalves on 26/11/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class UsersSearchController: UIViewController {
   
    @IBOutlet weak var resultsScroll: UIScrollView!
    @IBOutlet weak var searchField: SearchBar!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userSearchContainer: UIView!
    
    @IBOutlet weak var userResultContainerBackground: UIImageView!
    @IBOutlet weak var userContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingIndicator: GithubLoadingView!
    
    var searchingLabel: UILabel!

    var user: User?
    
    var timer: NSTimer?
    
    let userMovementAnimationDuration: NSTimeInterval = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.searchDelegate = self
        searchingLabel = UILabel(frame: CGRectMake(10, 20, resultsScroll.frame.width - 20, 20))
        searchingLabel.textColor = .whiteColor()
        resultsScroll.addSubview(searchingLabel)
        resultsScroll.contentSize = CGSizeMake(resultsScroll.frame.size.width, CGFloat(20));
    }

    private func restartTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(
            0.5,
            target: self,
            selector: "refreshSearchingLabel",
            userInfo: nil,
            repeats: true
        )
    }
    
    var points = 0
    
    @objc private func refreshSearchingLabel() {
        points += 1
        if points > 3 { points = 0 }
        searchingLabel.text = "Searching\(String(count: points, repeatedValue: Character(".")))"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UsersSearchToDetailSegue" {
            let vc = segue.destinationViewController as! UserDetailsController
            if let user = user {
                vc.user = user
            }
        }
    }
    
    private func searchUserFor(login: String) {
        showLoadingIndicatior()
        userSearchContainer.hide()
        userResultContainerBackground.hide()
        loadingIndicator.show()
        userContainerTopConstraint.constant = -80.0
        UIView.animateWithDuration(userMovementAnimationDuration) { self.view.layoutIfNeeded() }
        Users.GetOne(login: login).get(success: gotUser, failure: failedToSearchForUser)
    }
    
    private func gotUser(user: User) {
        userResultContainerBackground.hide()
        addLabelToScroll("Found user \(searchField.text!)")
        userLoginLabel.text = user.login!
        loadingIndicator.hide()
        userResultContainerBackground.hide()
        userSearchContainer.show()
        self.user = user
        ImageLoader.fetchAndLoad(user.avatarUrl!, imageView: avatarImageView)
        stopLoadingIndicator()
        
        userContainerTopConstraint.constant = 6.0
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    var numberOfSubviews = 2
    private func addLabelToScroll(text: String) {
        let label = UILabel(frame: CGRectMake(10, CGFloat(20 * numberOfSubviews), resultsScroll.frame.width - 20, 20))
        label.text = text
        label.textColor = .whiteColor()
        resultsScroll.addSubview(label)
        resultsScroll.contentSize = CGSizeMake(resultsScroll.frame.size.width, CGFloat(20 * (numberOfSubviews + 1)));
        numberOfSubviews += 1
        
        if resultsScroll.contentSize.height > resultsScroll.bounds.size.height {
            let bottomOffset = CGPointMake(0, resultsScroll.contentSize.height - resultsScroll.bounds.size.height);
            resultsScroll.setContentOffset(bottomOffset, animated: true)
        }
        
    }
    
    private func failedToSearchForUser(status: NetworkStatus) {
        loadingIndicator.hide()
        stopLoadingIndicator()
        if status.isTechnicalError() {
            NotifyError.display(NetworkStatus.messageForStatus(status))
        }
        if status == .NotFound {
            userSearchContainer.show()
            userContainerTopConstraint.constant = 6.0
            UIView.animateWithDuration(0.3) {
                self.view.layoutIfNeeded()
            }
            userResultContainerBackground.show()
        }
        addLabelToScroll(NetworkStatus.messageForStatus(status))
    }
    
    private func showLoadingIndicatior() {
        restartTimer()
    }
    
    private func stopLoadingIndicator() {
        timer?.invalidate()
        timer = nil
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension UsersSearchController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        if text.characters.count > 2 {
            searchUserFor(text)
            searchBar.resignFirstResponder()
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}