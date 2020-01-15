import React from "react";
import Container from "react-bootstrap/Container";
import ShortenForm from "../components/ShortenForm";
import LastShorts from "../components/LastShorts";
import Axios from "axios";

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
      <Container>
        <br/>
        <h1>Home</h1>
        <br/>

        <ShortenForm shortenUrl={this.shortenUrl}/>
        <br/>
        <LastShorts links={this.state.lastShorts}/>
      </Container>
    );
  }
}

export default Home;
