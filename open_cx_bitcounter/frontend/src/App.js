import React from 'react';
import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom'

import 'bootstrap/dist/css/bootstrap.min.css';
import './styles.css';


import Home from "./components/Home";
import Footer from "./components/Footer";
import Header from "./components/Header";

function App() {
  var adminKeyObject = {
    adminKey: '',
    keyGetter: function () {
      return this.adminKey;
    },
    keyHandler: function (newKey) {
      this.adminKey = newKey;
      console.log(this.keyGetter());
    }
  };

  adminKeyObject.keyHandler = adminKeyObject.keyHandler.bind(adminKeyObject);
  adminKeyObject.keyGetter = adminKeyObject.keyGetter.bind(adminKeyObject);

  return (
    <>
      <Header keyObject={adminKeyObject}/>
      <div className="container main-container">
        <Router>
          <Route path='/'
              render={(props) => <Home {...props} keyGetter={adminKeyObject.keyGetter} />}/>
        </Router>
      </div>
      <Footer />
    </>
  );
}
export default App;
