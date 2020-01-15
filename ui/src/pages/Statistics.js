import React from "react";
import Popular from "../components/Popular";
import Countries from "../components/Countries";
import Container from "react-bootstrap/Container";
import Breadcrumb from "react-bootstrap/Breadcrumb";
import Axios from "axios";

class Statistics extends React.Component {
  constructor(props) {
    super(props);
    this.state = { countries: [], links: [] };
  }

  getCountries = () => {
    Axios
      .get(window.API_URL + "countries")
      .then(response => this.setState({countries: response.data}));
  };

  getPopular = () => {
    Axios
      .get(window.API_URL + "popular")
      .then(response => this.setState({links: response.data}));
  };

  componentDidMount() {
    this.getPopular();
    this.getCountries();
  }

  render() {
    return(
      <div>
        <Container className="p-0 mt-3">
          <Breadcrumb>
            <Breadcrumb.Item href="/">Home</Breadcrumb.Item>
            <Breadcrumb.Item active>Statistics</Breadcrumb.Item>
          </Breadcrumb>
        </Container>
        <Container className="p-0">
          <h1>Statistics</h1>
          <div className="mt-4">
            <h2>Most popular links</h2>
            <Popular links={this.state.links}/>
          </div>
          <div className="mt-4">
            <h2>By Countries</h2>
            <Countries countries={this.state.countries}/>
          </div>
        </Container>
      </div>
    );
  }
}

export default Statistics;
