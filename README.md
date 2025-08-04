#ny_task
========

This project is a mobile application developed in Swift for iOS that displays a list of the most popular articles from the New York Times and allows users to view the 
details of each article. The application is built with a focus on a modular and testable design, following a clean architecture pattern.

Features
--------

*   **View Popular Articles**: Browse a list of the most popular articles.
    
*   **Article Details**: Tap on an article to view its detailed information, including title, abstract, and an external link.



🏗️ Architecture
--------

```mermaid
graph TD
    A[View] -->|Binds| B[ViewModel]
    B -->|Uses| C[Repository]
    C -->|Calls| D[APIClient]
    B -->|Navigates| E[Coordinator]
    F[DI Container] -->|Injects| B
 ```

## Technical Stack

### Core Technologies
- **UIKit** for UI components
- **Combine** for reactive programming
- **Async/Await** (for network service async calls)


### Architecture Components
- **MVVM-C Pattern**:
  - Model-View-ViewModel with Coordinators
  - Clean separation of concerns
  - Testable components

- **Dependency Injection**:
  - MSDIContainer for managing dependencies
  - Protocol-oriented design for easy mocking

- **Reactive Programming**:
  - Combine framework for state management
  - Data binding between ViewModels and Views


Getting Started
---------------

### Prerequisites

*   Xcode 15.0 or later
    
*   Swift 5.5 or later
    
*   iOS 15.0 or later
    

### Installation

1.  Clone the repository:
    *   git clone https://github.com/fahadahmedusmani3108/ny_task.git
    
2.  Open the project in xcode
    *   open NY_Task.xcodeproj.
    
3.  Update API Key:
    *   The application requires a New York Times API key.
        
    *   Locate the file Secure.xcconfig.
        
    *   Replace YOUR_API_KEY with your actual key.
        
4.  Build and run the project on a simulator or a physical device.
    

Running the Code
----------------

1.  Select the **NY_Task** scheme in Xcode.
    
2.  Choose a simulator or connected device.
    
3.  Press the "Run" button (▶) or use the shortcut Cmd + R.
    

Running Tests
-------------

This project includes unit tests to ensure the correctness of the business logic.

1.  Select the **NY_TaskTests** scheme in Xcode.
    
2.  Go to Product -> Test or use the shortcut Cmd + U.
    
3.  Xcode will run all the test cases and display the results.
    

Generating Coverage Reports
---------------------------

To generate a code coverage report for the tests:

1.  In Xcode, go to Product -> Scheme -> Edit Scheme....
    
2.  In the Test section, check the box for **"Gather coverage for target"** next to NY_Task.
    
3.  Run the tests again (Cmd + U).
    
4.  After the tests complete, the coverage report will be available in the **Report Navigator** (the last icon on the left pane).
    
5.  You can also view coverage directly in the code editor by clicking on the diamond icons in the gutter.
