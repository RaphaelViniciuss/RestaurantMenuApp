# RestaurantMenuApp

Restaurant Menu App is a project that offers a very elegant and functional menu based on UX. Implemented following good and modern software practices.
## Background

The main objective of this document is to document all my considerations and conceptions when making my decisions during the construction of the project.

>Upon receiving the UI design and API documentation, my biggest attention was to provide an application that:
>- With good performance;
>- Follow good practices and software principles such as SOLID for example;
>- Smooth and elegant animations;
>- With great scalability.

**I've considered using SwiftUI, Combine and async / await, but I need to study more before to applying this approach*
## Setup project
Before running the project there's an important step to setup.

In the file `info.plist` We've the key `ApiKey`, in this it's necessary to add the api key that the API requires ([Doc Link](https://documenu.com/docs)).

![api_key_setup](https://raw.githubusercontent.com/RaphaelViniciuss/RestaurantMenuApp/develop/README_FILES/api_key_setup.png)

[Opcional] If you want to change the ID of the restaurant that will be requested by the app, you can change the property `MOCK_ID` in `HomeViewModel.swift`.

![mock_id_setup](https://raw.githubusercontent.com/RaphaelViniciuss/RestaurantMenuApp/develop/README_FILES/id_setup.png)

## Technical Approaches

After reviewing the UI design and API documentation, we've several possible approaches to taking a restaurant's menu and displaying it to the user, from searching by restaurant ID to using geo polygon. Of all the possible options, I considered three options:

### Through ID

The API allows us to pass in a restaurant ID and receive its menu. It is one of the best options for receiving data from a specific restaurant.

Its important to mention here that it isn't usual to use the approach using the user-level ID, as, from a UX point of view, the user should not search through an identifier, but rather proposals as lists or redirectors without the user need to enter the ID specifically.

### By location
One possibility is with the user's geolocation informing Latitude and Longitude, its possible to receive a list of restaurants in the approximate geolocation informed.

Its important to consider that this approach needs to ask the user for permission to access the device's location.

Another important point is that this approach is a classic approach for applications that need to display options to the user within a region or area.

### Through an optional field
Its a possible approach, as the API allows the passing of information treated as optional (restaurant name, address, telephone, etc).
An interesting approach since there are several possibilities of data that the user can use to make a search and receive a restaurant (or a list).

### Which approach was chosen?
To choose an approach among the possible approaches, I analyzed the points that the approach needs to fit the visual prototype, points such as: **effort, practicality, harmony with UI design and behavior.**

Using the location approach would be great, but using this approach would only imply informing the user of the first restaurant on the list that an API offers, in terms of dynamism its excellent, but in terms of usability not so much because, for each location a menu otherwise, the idea of this approach would be a list of restaurants based on the API response, something that would require extra effort to create a new canvas that the UI design hasn't yet done.

Using the optional fields doesn't seem feasible to us, as we don't have an advanced search field/screen to receive user information and carry out the correct treatment of information, such as knowing, for example, which category of information the user entered? (city, address, etc.)
It would be possible to accept only a specific field as the name of the restaurant, but it would be necessary to prototype this screen with the search field for a better user experience.

What's left is the usage by ID approach, but the idea is to use this approach just as a beta phase and, as a next feature, a screen with a list of restaurants based on the user's location, if that makes sense for the model. of business.

## Technical Design

### Architecture
I believe this particular step is the most important part of project design. Even if it's just a screen, we know this project can grow and therefore it will need maintenance and this is exactly where good architecture makes all the difference! Well then, a good architecture allows us, in the long term, to grow the project efficiently and easily.
The goal is to have an architecture that:
- Have a clear division of responsibilities;
- Testable;
- Possibility to grow;
- Independence from external causes.

The Clean Architecture created by Robert C. Martin "Uncle Bob" meets all of these premises, making it an excellent candidate for our project

![clean_arch_design](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)
### Design Patterns
A pattern is always welcome as it brings more readable and maintainable code.
We've several naming standards (MVC, MVP, MVVM, etc).
I chose MVVM just on a whim, along with the coordinators pattern for our navigation, our pattern becomes something like MVVM-C.
### User Experience
About UX, we need to pay attention to the combination of behavior of the list of items and the horizontal menu at the top.

The list of menu items can be extensive and for the user it can be tiring scrolling through the list to see an item that is at the end of the list, it would be great to have shortcuts that make it easy for the user to navigate the list of items.

Another point of attention is the need to make it clear to the user which section they're viewing in the list as they scroll through the list, as the list can be long and can cause a lot of confusion as to which section the user is viewing.

### Tests

- It is essential that the application achieves at least 50% coverage with unit testing;
- Implement interface tests;
- Development using the TDD process;
- [Nice to have] Use BDD.
### Extra Resources

Considered as an extra, but it would be great to have:
- Dependency Injection;
- Design System;
- follow the [HIG](https://developer.apple.com/design/human-interface-guidelines/);
- Data binding using Observable without 3rd party libraries;
- Dark mode.

### Debit Tech
- Create an error status screen for the home view;
- Create unit tests for the Network and Data layer;
- Create UITests from the list of items;

## Files
In the home screen it isn't a good practical to manipulate the delegates of CollectionView contained in the HomeView from HomeViewController, it would be better than HomeView itself to manipulate it
### filepath
`HomeViewController.swift` shouldn't manipulate `menuSectionCollectionView` and `menuItemCollectionView` delegates and data sources in `HomeView.swift`.

```
lazy var homeView: HomeView = {
    let view = HomeView()
    view.menuSectionCollectionView.delegate = self
    view.menuSectionCollectionView.dataSource = self
    view.menuItemCollectionView.delegate = self
    view.menuItemCollectionView.dataSource = self
    return view
}()
```