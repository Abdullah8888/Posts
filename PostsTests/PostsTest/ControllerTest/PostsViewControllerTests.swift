//
//  PostViewControllerTests.swift
//  PostsTests
//
//  Created by Abdullah on 15/02/2022.
//

import XCTest
@testable import Posts

class PostsViewControllerTests: XCTestCase {

    func testCreatePostViewController() {
        let sut = makeSut()
        XCTAssertNotNil(sut)
    }
    
    func testPostViewControllerHasTableView() {
        let sut = makeSut()
        XCTAssertNotNil(sut._view.subviews.contains(sut._view.tableView))
    }
    
    func testThatTableViewHasDataSource() {
        let sut = makeSut()
        XCTAssertNotNil(sut._view.tableView.dataSource)
    }
    
    func testThatTableViewHasDelegate() {
        let sut = makeSut()
        XCTAssertNotNil(sut._view.tableView.delegate)
    }
    
    func testEmptyData() {
        let sut = makeSut(posts: [])
        XCTAssertTrue(sut._view.data?.isEmpty ?? true)
    }
    
    func testCreateCell() {
        let sut = makeSut()
        let cell = sut._view.postsDataSource?.tableView(sut._view.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PostsCell
        XCTAssertNotNil(cell, "No cell created")
    }
    
    func testFirstEntryUsername() {
        let sut = makeSut()
        let cell = sut._view.postsDataSource?.tableView(sut._view.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PostsCell
        XCTAssertEqual(cell.usernameLabel.text, "John")
    }
    
    func testTableViewNumberOfRowsSection() {
        let sut = makeSut()
        XCTAssertEqual(sut._view.postsDataSource?.tableView(sut._view.tableView, numberOfRowsInSection: 0), 2, "Tableview has no rows")
    }
    
    func testCalculateCellHeight() {
        let sut = makeSut()
        let cellHeight = sut._view.postsDataSource?.calculateCellHeight(IndexPath(row: 0, section: 0))
        guard let cellHeight = cellHeight else {
            return
        }
        XCTAssertEqual(round(cellHeight), 212)
    }
    
    func makeSut(posts: [UserWithPost] =  MockUserWithPost().data) -> PostsViewController {
        let tableView = UITableView()
        let postView = PostsView()
        tableView.tag = 4567
        postView.tableView = tableView
        postView.setup()
        postView.data = posts
        return PostsViewController(view: postView)
    }

}

struct MockUserWithPost {
    
   var data: [UserWithPost] {
    let post1 = UserWithPost()
    post1.userId = 1
    post1.username = "John"
    post1.avatar = ""
    post1.title = "Saugen Sie etwa noch selbst?"
    post1.body = "Saugen Sie etwa noch selbst? Der LG HomBot Square übernimmt den Job zuverlässig. Mit seinen zwei Kameras navigiert der Saugroboter präzise durch die Räume oder einen festgelegten Bereich und reinigt sogar im Dunkeln. Dank der Ultraschallsensoren bewegt er sich besonders vorsichtig, meistert selbst Kanten und Schwellen mühelos und saugt bis in die Ecken. Und selbst wischen kann der neue Hausfreund"
        
    let post2 = UserWithPost()
    post2.userId = 2
    post2.username = "Dafa"
    post2.avatar = ""
    post2.title = "Bereich und reinigt sogar"
    post2.body = "It is simply dummy text of the printing and typesetting industry."
    return [post1, post2]
   }
}


