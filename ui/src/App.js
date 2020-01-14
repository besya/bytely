import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import Home from './pages/Home';
import Statistics from "./pages/Statistics";
import Container from "react-bootstrap/Container";
import Header from "./components/Header";

if(process.env.NODE_ENV === 'development'){
  window.API_URL = "http://localhost:8080/api/";
} else {
  window.API_URL = "/api/";
}

function App() {
  return (
    <div className="App">
      <Router>
        <Container>
          <Header />
        </Container>
        <div>
          {/* A <Switch> looks through its children <Route>s and
            renders the first one that matches the current URL. */}
          <Switch>
            <Route path="/statistics">
              <Statistics />
            </Route>
            <Route path="/">
              <Home />
            </Route>
          </Switch>
        </div>
      </Router>
    </div>
  );
}

export default App;
