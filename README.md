# README

## Links 

### Link to Website 

Client side: https://github.com/IraShy/Shorties-app-client

Back end: https://shorties-server.herokuapp.com

### Link to Repo

Client side repo: https://github.com/IraShy/Shorties-app-client

Server side repo: https://github.com/jishan33/Shorties-app-server

## Instruction for Setup 

### System Dependencies

#### Rails 
- rails 6.0.3
- bundler 2.1.2

#### React 
- react-scripts 3.4.1
- yarn 1.22.4

### Credentials 

#### Rails
```
aws:
  access_key_id: <secret>
  secret_access_key: <secret>

recaptcha:
  site_key: <secret>
  secret_key: <secret>

```

## Running Code & Tests
### Rails
 - To install dependencies   `bundle install`
 - To run the tests   `./bin/rspec`
 - To start the app   `rails s`

 ### React
  - To install dependencies  `yarn install`
  - To run the tests  `yarn run e2e`
  - To start the app  `yarn start`

## Libraries 

### Rails 
 - RSpec 
 - Factory Bot Rails
 - Knock
 - JWTs
 - Cors
 - Recaptcha
 - Aws

 ### React 

 - Context
 - Cypress 
 - React Router Dom
 - React ReCaptcha Google
 - Lodash
 - Prop Types
 - moment
 - React Bootstrap
 - Joi browser
 - React Select
 - SASS
 - React Animations


 
## Link to postman 

  https://documenter.getpostman.com/view/10733565/T1DteFk7?version=latest

### Developer journal

We organised 2 Trello boards, one for each part of the project. 

For part A, we made screenshots every day as per requirements to document our progress. For part B, after having discussed this matter with the teachers, we did not do screenshots but started documenting our project in an additional list on Trello, just briefly listing what we did every day.

**Part A**

In the documentation phase of the project, we started from thinking about ideas. Jishan organised Trello boards for both parts, and both of us took part in adding sources and links to help us with the tasks.

We presented and discussed our ideas on Monday, and after agreeing on the Shorties idea and discussing it with the teachers, we delegated tasks.

Jishan made application architecture diagram and wireframes for desktop, notepad, and mobile.

Iryna wrote user stories and made dataflow diagram.

Both of us worked on ERD, and Jishan made sure we were on the same page about out database and models needs, as at first we had different understanding of what they should be.

Readme.md for the first part is also the reault of our mutual work.

We discussed the features we wanted to implement in the project and adjusted our documentation accordingly.

**Part B**

Work on Part B of the project started 15.07.2020.

To navigate between tasks, we had coding and testing parts in our board.
Lists that we had:
- "to do" lists: TO DO (React), TO DO (Rails), TO DO (Test)
- "doing" lists: IN PROGRESS - for coding, DOING (TESTS)
- "review" lists for code and tests
- "done" lists for code and tests
- BLOCKING list
- EXTRA list - for ideas to implement if we have time after finishing what we planned
- RESOURCES list - links to all resources we needed to work on the project, e.g. to GitHub repos and Help Trello board
- Dev Journal list to document day-to-day progress

We followed a colour-blocking schene we agreed upon, so each team member could easily see what the other one is doing at the moment.


15.07

- Jishan organised server-side repository, Iryna organised client-side repository on GitHub
- Created and tested models
- Jishan, as the server-side repo owner, organised S3 bucket and deployed to Heroku
- Iryna deployed to Netlify
- Knock authentication - done through pair programming
- Started planning what components we'll need in React, created initial list which was later updated
- Came up with the app name
- Set up RSpec for tests in Rails
- Started adding initial components to client side

16.07
- Continued TDD in Rails, testing and writing code for controllers
- Request Tests ( Note, Cohort, Category, Status )
- Authentication Test 
- Controller Tests ( Note, Cohort, Category, User )


17.07
- Tests Revision
- Authentication in React: login, signin, protectedroutes, context
- Bootstrap and SASS installation
- Set up Cypress for tests in React
- Continue working on components in React: Login, Signup, ProtectedRoute

18.07
- Jishan started adding styling
- Fixed Context
- Notes

19.07 (Sunday)
Wireframe revision 

20.07
- Search functionality implemented by Iryna
- Delete function on AddNote
- Rails tests - Jishan continued updating tests throughout the project lifecycle
- Multi-select drop down in AddNote implemented by Jishan

21.07
- Iryna attempted to implement pictures uploading (initial plan was to nave many pictures attached but was changed to 1 picture)
- Show in react completed 
- Update in react in progress

22.07
- Fixed image upload - Iryna
- EditNote can edit note and its own categories in one form - Jishan worked on CreateNote and AddNote
- Fixed the note request tests after the EditNote updated 

23.07
- Completed image edit feature - Jishan had a lot to do with the add and edit parts as we have the many categories feature
- Fixed the related RSpec request tests 
- Added pagination and marked as completed features added - Jishan
- Completed cypress login and signup tests - Iryna

24.07
- extracted dropdown components from AddNote and EditNote
- form validations in progress - Jishan
- AddCohort functionality with multiple users (students) implemented by Iryna
- Cohorts component - Iryna
- git conflicts and debugging - both members throughout the project

25.07 (Sunday)
- AddCohort finished 
- Started doing Cohorts and ShowCohort components

26.07
- Cohorts 
- ShowCohort and removing stuidents from a cohort
- started doing Categories
- Iryna created the second protected routes file in an attempt to minimize unnecessary fetch requests tot the server side, but eventually the protected route files were combined as we needed to send various requests simultaniously at some point

27.07
- Form validations: AddNote and EditNote
- Code refactoring
- ShowCategory
- Signup redirect
- Share notes functionality
- Styling: Categories, ShowCohort
- Added Recaptcha

28.07
- Add styling on ( Notes, AddNote, EditNote, ShowNote, ShowCategory, Login, Signup ) for mobile version. 
- Fixed validation & login test. 
- Created Spreadsheet with test cases for manual testing
- Iryna executed test cases in development environment, documented bugs
 
 29.07
- Updated notes styling
- Added popover and alerts for buttons 
- Added completedNotes section 
- Fix bugs
- Home page - content and styling
- Debugging
- Re-testing in development after debugging

30.07
- Debugging
- Deploying and re-deploying
- Manual testing in development
- Minor fixes
- Documentation

Generally, tasks were divided mostly as follows:

Jishan worked on authentication-related problems, including form validations and recaptcha; Notes (the most difficult, significant and time-consuming part of the project) - creating, editing, rendering, sharing; and its related Rspec testing in Rails.

Iryna worked on Cohorts and Categories, implemented search feature and image uploading. Iryna did some testing in React and manual testing in development and production.

Styling: team members added styling to the parts they worked on, and polished everything together. 








