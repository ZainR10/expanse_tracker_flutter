Introduction
The Expense Tracker App is designed to help users manage their finances efficiently. The app allows users to track their income and expenses, view analytics, and gain insights into their spending habits. The target audience includes individuals who want to keep a close watch on their financial activities and ensure better budgeting.

Requirements
The app includes the following functionalities and features:

Add, edit, and delete expenses and income entries.
View a summary of total balance, expenses, and remaining balance.
Visualize data through pie charts showing expense categories and balance vs. expenses.
Navigate between different screens for home, analytics, adding entries, viewing expense lists, and settings.
Store and retrieve data from a cloud database (Firestore).
System Design
Architecture
The app follows the MVVM (Model-View-ViewModel) architecture, which separates the user interface (UI) from the business logic and data handling, making the codebase more manageable and scalable.

Databases
The app uses Firebase Firestore to store expense and balance data. Each expense entry is saved in a collection, and the total balance is stored in a separate document.

User Interface Design
The UI is built using Flutter, providing a smooth and responsive user experience. Key UI components include:

Custom navigation bar for easy navigation between screens.
Pie charts for visual representation of expenses and balance.
Dropdowns and lists for selecting and viewing data.
External Integrations
The app integrates with Firebase for data storage and real-time updates.

Implementation Details
Technologies Used
Programming Languages: Dart
Frameworks: Flutter
Backend Services: Firebase Firestore,Firebase Auth
State Management: Provider
Coding Decisions
MVVM Architecture: Chosen for its ability to separate concerns, making the app more maintainable and testable.
Provider: Used for state management to efficiently handle state changes and rebuild only necessary parts of the UI.
Firestore: Selected for its real-time capabilities and seamless integration with Flutter.
Firebase Auth: To signup and signin user with firebase.
Future Considerations
There are several features and functionalities considered for future implementation:

Data Export: Adding the ability to export data to Excel and Google Sheets, providing users with more flexibility in handling their financial data.
Notifications: Implementing push notifications to remind users of upcoming expenses or low balance alerts.
Advanced Analytics: Incorporating more detailed analytics and insights, such as trend analysis and budget recommendations.
 internationally.

Project Screen shots:
![splash screen](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/4f80af10-943f-4091-80eb-a1e0e2192cec),
![signup page](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/9e389197-4b1d-443a-a355-ad7196863413),
![settings](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/94a4569e-b544-41f4-b6b8-f97c3e7dd7a7),
![pi chart](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/4efd0ed4-7a52-4496-90c1-8a4ada8acf29),
![pi chart for categories](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/54050177-d943-4fe3-ad95-c13b3d7ddcdf),
![login page](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/d06610dd-7b1c-4fef-b73a-84c08c9b841e),
![home view with listti![home screen](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/fa6e104e-90d0-4fa1-9cd1-0e77f86e5b95),
le](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/19c922de-688c-4519-9ea4-5f0d7d362d0c),
![full list view](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/591322a5-9d7b-4840-a99f-96a29558f69e),
![expanse dialog box](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/5189c5e0-6354-4efc-9447-d256dcac6a29),
![delete](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/bafdd3e7-b023-4bd1-953f-dff10028d3de),
![firebase](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/ae0b9bfb-9885-4b3a-b29b-e3f1ac03ed66),
![firebase 2](https://github.com/ZainR10/expanse_tracker_flutter/assets/128054811/867dbf4b-928d-4ac3-a3cf-b16982b458a1)
