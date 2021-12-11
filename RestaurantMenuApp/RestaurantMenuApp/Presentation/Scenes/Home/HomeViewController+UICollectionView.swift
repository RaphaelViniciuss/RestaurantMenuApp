//
//  HomeViewController+UICollectionView.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeView.menuSectionCollectionView {
            let row = indexPath.row
            let index = IndexPath(item: .zero, section: row + 1)
            shouldHighlightOnScroll = false
            homeView.menuItemCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
            homeView.menuSectionCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        shouldHighlightOnScroll = true
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        shouldHighlightOnScroll = true
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {

        if elementKind == UICollectionView.elementKindSectionHeader,
           indexPath.section != .zero,
           shouldHighlightOnScroll {
            let index = IndexPath(item: indexPath.section-1, section: .zero)
            homeView.menuSectionCollectionView.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
        }

    }
}

extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView == homeView.menuSectionCollectionView ? 1 : restaurant?.menus.first?.menuSections.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        guard collectionView != homeView.menuSectionCollectionView else {
            return restaurant?.menus.first?.menuSections.count ?? .zero
        }

        return section == .zero ? .zero : restaurant?.menus.first?.menuSections[section-1].menuItems.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard collectionView != homeView.menuSectionCollectionView else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSectionCell", for: indexPath) as! MenuSectionCell
            cell.sectionTitle = restaurant?.menus.first?.menuSections[indexPath.row].sectionName
            return cell
        }

        let itemRows = restaurant?.menus.first?.menuSections[indexPath.section-1].menuItems
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell

        if let rows = itemRows {
            cell.configure(with: rows[indexPath.row])
            cell.isLastItem = indexPath.row == rows.count - 1
        }

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let identifier: String = collectionView == homeView.menuSectionCollectionView ? "MenuSectionEmptyCell" : "MenuItemEmptyCell"

        if kind == UICollectionView.elementKindSectionHeader,
           collectionView != homeView.menuSectionCollectionView,
           indexPath.section != .zero {
            return configureItemHeader(collectionView, at: indexPath)
        }

        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath)
    }

    private func configureItemHeader(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {

        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuItemHeaderCell", for: indexPath) as! MenuItemHeaderCell

        if let name = restaurant?.menus.first?.menuSections[indexPath.section-1].sectionName {
            sectionHeader.configure(with: name)
        }

        return sectionHeader
    }
}
