//
//  UserPresenterTests.swift
//  GitHubAwards
//
//  Created by Nuno Gonçalves on 18/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import Quick
import Nimble
import XCTest
@testable import GitHubAwards

class UserPresenterTests: QuickSpec {
    
    override func spec() {
        
        var user: User!
        var userPresenter: UserPresenter!

        describe("UserPresenter") {
            context("User is first in ranking") {
                beforeEach {
                    user = User(login: "nuno", avatarUrl: "AvatarUrl")
                    userPresenter = UserPresenter(user: user, ranking: 1)
                }
                
                it("is in podium") {
                    XCTAssertEqual(userPresenter.isPodiumRanking(), true)
                }
                
                it("has 1st place background color") {
                    XCTAssertEqual(
                        userPresenter.backgroundColor(),
                        K.firstInRankingColor,
                        "Expected 1st place color to be \(K.firstInRankingColor)"
                    )
                }
                
                it("has 1st place avatar background color") {
                    XCTAssertEqual(
                        userPresenter.avatarBackgroundColor(),
                        K.secondInRankingColor,
                        "Expected 1st place color to be \(K.secondInRankingColor)"
                    )
                }

                it("returns gold trophy image name") {
                    XCTAssertEqual(userPresenter.rankingImageName(), "1.png", "Expected image name to be 1.png")
                }
                
                it("returns login") {
                    XCTAssertEqual(userPresenter.login(), "nuno", "Expected login to be Nuno")
                }
                
                it("returns avatar url") {
                    XCTAssertEqual(userPresenter.avatarUrl(), "AvatarUrl", "Expected avatar to be AvatarUrl")
                }
            }
            
            context("User is second in ranking") {
                beforeEach {
                    user = User(login: "Katrina", avatarUrl: "KatrinaAvatarUrl")
                    userPresenter = UserPresenter(user: user, ranking: 2)
                }
                
                it("is in podium") {
                    XCTAssertEqual(userPresenter.isPodiumRanking(), true)
                }
                
                it("has 1st place background color") {
                    XCTAssertEqual(
                        userPresenter.backgroundColor(),
                        K.secondInRankingColor,
                        "Expected 1st place color to be \(K.secondInRankingColor)"
                    )
                }
                
                it("has 2nd place avatar background color") {
                    XCTAssertEqual(
                        userPresenter.avatarBackgroundColor(),
                        K.thirdInRankingColor,
                        "Expected 2nd place color to be \(K.thirdInRankingColor)"
                    )
                }
                
                it("returns silver trophy image name") {
                    XCTAssertEqual(userPresenter.rankingImageName(), "2.png", "Expected image name to be 2.png")
                }
                
                it("returns login") {
                    XCTAssertEqual(userPresenter.login(), "Katrina", "Expected login to be Katrina")
                }
                
                it("returns avatar url") {
                    XCTAssertEqual(userPresenter.avatarUrl(), "KatrinaAvatarUrl", "Expected avatar to be KatrinaAvatarUrl")
                }
            }
            
            context("User is third in ranking") {
                beforeEach {
                    user = User(login: "Bianca", avatarUrl: "BiancaAvatarUrl")
                    userPresenter = UserPresenter(user: user, ranking: 3)
                }
                
                it("is in podium") {
                    XCTAssertEqual(userPresenter.isPodiumRanking(), true)
                }
                
                it("has 3rd place background color") {
                    XCTAssertEqual(
                        userPresenter.backgroundColor(),
                        K.thirdInRankingColor,
                        "Expected 3rd place color to be \(K.thirdInRankingColor)"
                    )
                }
                
                it("has 3rd place avatar background color") {
                    XCTAssertEqual(
                        userPresenter.avatarBackgroundColor(),
                        0xE5E5FF,
                        "Expected 3rd place color to be \(0xE5E5FF)"
                    )
                }
                
                it("returns bronze trophy image name") {
                    XCTAssertEqual(
                        userPresenter.rankingImageName(),
                        "3.png",
                        "Expected image name to be 3.png"
                    )
                }
                
                it("returns login") {
                    XCTAssertEqual(
                        userPresenter.login(),
                        "Bianca",
                        "Expected login to be Bianca"
                    )
                }
                
                it("returns avatar url") {
                    XCTAssertEqual(
                        userPresenter.avatarUrl(),
                        "BiancaAvatarUrl",
                        "Expected avatar to be BiancaAvatarUrl"
                    )
                }
            }
            
            context("User is fourth in ranking") {
                beforeEach {
                    user = User(login: "HarrisonFord", avatarUrl: "HarrisonAvatarUrl")
                    userPresenter = UserPresenter(user: user, ranking: 4)
                }
                
                it("is not in podium") {
                    XCTAssertEqual(userPresenter.isPodiumRanking(), false)
                }
                
                it("has 4th place background color") {
                    XCTAssertEqual(
                        userPresenter.backgroundColor(),
                        nil,
                        "Expected 4th place color to be nil"
                    )
                }
                
                it("has 4th place avatar background color") {
                    XCTAssertEqual(
                        userPresenter.avatarBackgroundColor(),
                        nil,
                        "Expected 4th place color to be nil"
                    )
                }
                
                it("returns regular trophy image name") {
                    XCTAssertEqual(
                        userPresenter.rankingImageName(),
                        nil,
                        "Expected image name to be nil")
                }
                
                it("returns login") {
                    XCTAssertEqual(userPresenter.login(), "HarrisonFord", "Expected login to be HarrisonFord")
                }
                
                it("returns avatar url") {
                    XCTAssertEqual(userPresenter.avatarUrl(), "HarrisonAvatarUrl", "Expected avatar to be HarrisonAvatarUrl")
                }
            }
            
            context("User is 1000th in ranking") {
                beforeEach {
                    user = User(login: "Walter White", avatarUrl: "WalterWhiteAvatarUrl")
                    userPresenter = UserPresenter(user: user, ranking: 1000)
                }
                
                it("is not in podium") {
                    XCTAssertEqual(userPresenter.isPodiumRanking(), false)
                }
                
                it("has regular place background color") {
                    XCTAssertEqual(
                        userPresenter.backgroundColor(),
                        nil,
                        "Expected 4th place color to be nil"
                    )
                }
                
                it("has regular place avatar background color") {
                    XCTAssertEqual(
                        userPresenter.avatarBackgroundColor(),
                        nil,
                        "Expected 4th place color to be nil"
                    )
                }
                
                it("returns regular trophy image name") {
                    XCTAssertEqual(
                        userPresenter.rankingImageName(),
                        nil,
                        "Expected image name to be nil")
                }
                
                it("returns login") {
                    XCTAssertEqual(userPresenter.login(), "Walter White", "Expected login to be HarrisonFord")
                }
                
                it("returns avatar url") {
                    XCTAssertEqual(userPresenter.avatarUrl(), "WalterWhiteAvatarUrl", "Expected avatar to be HarrisonAvatarUrl")
                }
            }
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testPerformanceExample() {
//        self.measureBlock {}
    }

}
