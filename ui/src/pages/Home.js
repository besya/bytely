import React from "react";
import Container from "react-bootstrap/Container";
import ShortenForm from "../components/ShortenForm";
import LastShorts from "../components/LastShorts";
import Axios from "axios";
import Jumbotron from "react-bootstrap/Jumbotron";

class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {lastShorts: []};
  }

  shortenUrl = (url) => {
    return Axios
      .post(window.API_URL + 'shorten', {url: url}, { headers: {'Content-Type': 'application/json'}})
      .then(response => response.data)
      .then(this.handleDataFormat)
      .then(this.addToLastShorts);
  };

  addToLastShorts = link => {
    this.setState({lastShorts: this.state.lastShorts.slice(-2).concat([link])});
    return link;
  };

  handleDataFormat = data => {
    if(data.hasOwnProperty('errors')){
      throw new Error(data.errors[0]);
    } else{
      return data;
    }
  };

  render() {
    return(
      <div>
        <Container>
          <Jumbotron className="bg-white pl-0">
            <h1>Create Click-Worthy Links</h1>
            <p>
              Build and protect your brand using powerful, recognizable short links.
            </p>
          </Jumbotron>
        </Container>
        <Container className="bg-dark pt-3">
          <ShortenForm shortenUrl={this.shortenUrl}/>
        </Container>
        <Container className="bg-dark">
          <LastShorts links={this.state.lastShorts}/>
        </Container>
      </div>
    );
  }
}

export default Home;
