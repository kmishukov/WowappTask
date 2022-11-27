//
//  ContactsViewController.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

final class ContactsViewController: UIViewController, ContactsBaseCoordinated {
    var coordinator: ContactsBaseCoordinator?

    // Views
    private let searchBar = UISearchBar(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let navigationTitle = "All Contacts"
    private let activityIndicator = UIActivityIndicatorView(frame: .zero)

    // Data
    private let dataManager = ContactsDataManager()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        dataManager.loadContacts { [weak self] success in
            self?.activityIndicator.stopAnimating()
            if success {
                self?.tableView.reloadData()
            } else {
                self?.showAlert(title: "Error", message: "Could not update list")
            }
        }
        setupViews()
    }

    private func setupViews() {
        navigationItem.title = navigationTitle
        view.backgroundColor = .white
        addNavigationButtons()
        setupActivityIndicator()
        setupSearchBar()
        setupTableView()
    }

    private func addNavigationButtons() {
        let groupsButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(groupsButtonTapped))
        groupsButton.title = "Groups"
        navigationItem.setLeftBarButton(groupsButton, animated: false)

        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.setRightBarButton(addButton, animated: false)
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.leftAnchor.constraint(equalTo: view.leftAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: view.rightAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupSearchBar() {
        searchBar.isUserInteractionEnabled = false // Disabled
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: ContactTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ContactTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Private

    private func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !actions.isEmpty {
            actions.forEach { alertController.addAction($0) }
        } else {
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
        }
        present(alertController, animated: true)
    }

    // MARK: - Actions

    @objc
    private func addButtonTapped() {
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            self?.coordinator?.parentCoordinator?.moveTo(.first)
        })
        let noAction = UIAlertAction(title: "No", style: .default)
        showAlert(title: "Action", message: "Move to First Tab?", actions: [yesAction, noAction])
    }

    @objc
    private func groupsButtonTapped() {
        showAlert(title: "Action", message: "Groups button tapped")
    }
}


// MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataManager.numberOfGroups()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataManager.numberOfRows(groupIndex: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.cellIdentifier, for: indexPath)
        let viewModel = dataManager.contact(groupIndex: indexPath.section, contactIndex: indexPath.row)
        (cell as? ContactTableViewCell)?.updateWith(viewModel: viewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dataManager.titleForGroup(section)
    }
}
