# open-cx - backend setup

## Server architecture, environments and installation

### How does open_cx_server work?
The folder **open_cx_server** contains code linked to the backend of the main open-cx project. We are using several technologies to make development easy and as seamless as possible. Amongst the several ones we're using, the following stand out:

- **MongoDB** - a cross-platform document-oriented database program. Classified as a NoSQL database program, MongoDB uses JSON-like documents with schema.
- **Mongoose** - provides a straight-forward, schema-based solution to model your application data. It includes built-in type casting, validation, query building, business logic hooks and more, out of the box.
- **Express** - it's a web application framework for Node.js, designed for building web applications and APIs.

### How can I use the **remote** server?

We have deployed the API to a Heroku server. You can send requests to it through the following link: open-cx.herokuapp.com/.

The way to exchange information with the API is very simple: you just append the location of one of the routers to the API link. 

**Important note about the server:** the server enters sleep mode when not accessed for 1 hour and thus, on that occasion, it will take 15-20 seconds to be executed. The following requests will be responded promptly.

### How can I install and run the server-side environment **locally**?

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

Your backend will now be available at address http://0.0.0.0:5000.

### How does Docker work as of today?
In order to use the API with Docker, one must perform one of these steps:
1. To create an environment variable to connect with the MongoDB database string (recommended);

2. To create the MongoDB database locally.

### What is and how shall I use the Active-admin platform?
Active-admin is a platform that supports CRUD (create, retrieve, update, delete) operations and can be used in order to update database entries manually. It's a good way to populate the database using an interactive, browser-based UI. With the backend running, access http://0.0.0.0:5000/admin/. 
In order to access Active-admin, please add it to the app.js file and define its route.

### How can I access the Active-admin (CRUD) platform on the **remote** server?
Please access the URL http://open-cx.herokuapp.com/admin in order to perform the CRUD operations over previously created models.


## API and DB development

### How can I send requests to the API during development?
You can use **Postman**. It's a great tool when trying to dissect RESTful APIs made by others or test ones you have made yourself. It offers a sleek user interface with which to make HTML requests, without the hassle of writing a bunch of code just to test an API's functionality. If you're using Ubuntu, it should be available in the software store a an electron app.

### How shall I submit changes (pull requests) to server code (you will need this to adapt the database and API to your domain model)?
- Fork the repository;

- Make the changes you think are needed;

- Create a pull request, choosing the **dev** branch as the merge target;

- **Frequently** check out the pull request, as comments can be made and revisions can be requested in order for it to be approved;

- The pull request will be merged as soon as possible.

### How shall I add an attribute (analogous to a field on a database)?
If you want to add an attribute to an already existing schema, you should:

- Open the schema file (all of them are located in the **models** folder), and add a new entry to the eventSchema object. You should be fine by following the already existing code in that folder.

- Go to the **routes/** folder and add/alter the router functions according to your needs.

- In the **routes/index.js** file add the new router you created.

For instance, in order to add an attribute username to the schema Speaker:

#### Step 1 - Avoid rework

Before adding a new attribute, please **check it doesn't exist in the previously created models**. Also, **before creating new routers, please check if there's already one that can serve your needs**.

#### Step 2 - Model

Open file models/speaker.js and add the attribute username with type String (or other) stating whether it is required.
```
username: {
    type: String,
    required: true
  },
```

#### Step 3 - Routes

Open folder routes/speakers/ to access the three required files (index.js, all.js, single.js). On the all.js and single.js the business logic shall be implemented accordingly (first add the route to index.js and then write it down on all.js and single.js).

### How do I add a schema (analogous to a table) to the database?

#### Step 1 - Avoid rework

Before adding a new schema, please **check it doesn't exist in the previously created models**. Also, **before creating new routers, please check if there's already one that can serve your needs**.

#### Step 2 - Model

Go to the **models** folder and create a new file similar to the already existing ones. For more information on how to create a schema, check the following link: https://mongoosejs.com/docs/guide.html;

#### Step 3 - Routes

Add new routers in the **routes/** folder according to your needs.

#### Step 4 - Routes' index.js

Open file routers/index.js and add the entries:
```
const speakers = require('./speakers');
routes.use('/speakers', speakers);
```

#### Step 5 - app.js

Open the **app.js** file, and in the "Middlewares" section, add the file you have just created containing the new routers, using the app.use() method (check the existing code and procede analogously)

#### Step 6 - admin.js

Go to the **admin.js** file and add a new object to the **resources**  array of the **adminBro** object, following this structure:

```Bash
{
  resource: NameOfTheSchema
}
```

### How can I populate the database?

You can follow one of the two following alternatives:

- Access the API's admin interface through the address http://0.0.0.0:5000/admin/ and add new entries through it;

- Make a post request using, for example, Postman, as mentioned above.

### How can I integrate my flutter app with the backend?

Some documentation is available to help on this integration, for instance:
- https://flutter.dev/docs/cookbook/networking/fetch-data

- https://flutter.dev/docs/cookbook/networking/fetch-data#3-convert-the-response-into-a-custom-dart-object

- https://pub.dev/packages/http.
