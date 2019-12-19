# open-cx - backend setup

## How does open_cx_server work?
The folder **open_cx_server** contains code linked to the backend of the main open-cx project. We are using several technologies to make development easy and as seamless as possible. Amongst the several ones we're using, the following stand out:

- **MongoDB** - a cross-platform document-oriented database program. Classified as a NoSQL database program, MongoDB uses JSON-like documents with schema.
- **Mongoose** - provides a straight-forward, schema-based solution to model your application data. It includes built-in type casting, validation, query building, business logic hooks and more, out of the box.
- **Express** - it's a web application framework for Node.js, designed for building web applications and APIs.

Because we want the creation and deployment of our backend to be built on top of a common architecture, we will be allowing the usage of **Docker** containers, so that we can package up applications with all of the parts it needs - such as libraries and other dependencies - and ship it all out as one package. Although Docker integration won't be initially available, we will try our best to deliver it as soon as we possibly can.

## How can I use the API?

We have deployed the API to a Heroku server. You can send requests to it through the following link: open-cx.herokuapp.com/.

The way to exchange information with the API is very simple: you just append the location of one of the routers to the API link. 

The following is an example of how to get the whole information about every user in the database:
- Because we want to get information on users, 

## How can I install and run the server-side environment **locally**?

We'll be considering you're using a Linux 64-bit machine.

Note that, for now, you'll be creating your own instance of the MongoDB database, and running the API locally on your computer.

We'll be creating an online instance of the database and update this file with new instructions as soon as possible.

#### Pre-requisites
Update the packages index:
```Bash
sudo apt-update
```

#### Step 1 - installing Node.JS

Install NodeJS:
```Bash
sudo apt install nodejs
```

To verify the instalation, execute the following command:
```Bash
nodejs --version
```

You should see printed on the terminal the version you've just installed. For example:

```Bash
v8.10.0
```

#### Step 2 - installing Node.js package manager (npm)

Install npm:
```Bash
sudo apt install npm
```

To check which version of Node.JS you have installed, run:

```Bash
nodejs -v
```

First, clone the repository:

```Bash
git clone https://github.com/softeng-feup/open-cx
```

Go to the folder containing the backend:

```Bash
cd open_cx_server
```

Install dependencies:

```Bash
npm install
```

Create an instance of the database following this tutorial: https://docs.atlas.mongodb.com/create-new-cluster/.

Create a dotenv file with the connection string of your database. It should be similar to this:

```Bash
DB_CONNECTION="mongodb+srv://user:password@project.gcp.mongodb.net/test?retryWrites=true&w=majority"
```
Finally, let's get the backend up and running:

```Bash
npm start
```

Your backend will now be available at address http://0.0.0.0:2222.

## How can I send requests to the API during development?
You can use **Postman**. It's a great tool when trying to dissect RESTful APIs made by others or test ones you have made yourself. It offers a sleek user interface with which to make HTML requests, without the hassle of writing a bunch of code just to test an API's functionality. If you're using Ubuntu, it should be available in the software store a an electron app.

## How shall I submit changes (pull requests) to server code?
- Fork the repository;
- Make the changes you think are needed;
- Create a pull request, choosing the **dev** branch as the merge target;
- **Frequently** check out the pull request, as comments can be made and revisions can be requested in order for it to be approved.

## How shall I add an attribute (analogous to a field on a database)?
If you want to add an attribute to an already existing schema, you should:

-  open the schema file (all of them are located in the **models** folder), and add a new entry to the eventSchema object. You should be fine by following the already existing code in that folder.

- go to the **routes/** folder and add/alter the router functions according to your needs.

- in the **routes/index.js** file add the new router you created.


## How can I populate the database?

Before adding a new attribute, please **check it doesn't already exists in the included models**. 

Also, **before creating new routers, please check if there's already one that can serve your needs**.

You can follow one of the two following alternatives:

- Access the API's admin interface through the address http://0.0.0.0:5000/admin/ and add new entries through it;

- Make a post request using, for example, Postman.

## How do I add a schema (analogous to a table) to the database?
-  go to the **models** folder and create a new file similar to the already existing ones. For more information on how to create a schema, check the following link: https://mongoosejs.com/docs/guide.html;

- add new routers in the **routes/posts** folder according to your needs;

- open the **app.js** file, and in the "Middlewares" section, add the file you have just created containing the new routers, using the app.use() method (check the existing code and procede analogously)


## What is and how shall I use the Active-admin platform?
Active-admin is a platform that supports CRUD (create, retrieve, update, delete) operations and can be used in order to update database entries manually. It's a good way to populate the database using an interactive, browser-based UI. With the backend running, access http://0.0.0.0:2222/admin/.

