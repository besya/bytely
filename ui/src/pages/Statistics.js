import React from "react";
import Popular from "../components/Popular";
import Countries from "../components/Countries";
import GeneralStatistics from "../components/GeneralStatistics";
import Container from "react-bootstrap/Container";
import Breadcrumb from "react-bootstrap/Breadcrumb";
import Axios from "axios";

class Statistics extends React.Component {
  constructor(props) {
    super(props);
    this.state = { countries: [], links: [], totalRedirects: 0, uniqueRedirects: 0 };
  }

  getCountries = () => {
    Axios
      .get(window.API_URL + "countries")
      .then(response => this.updateCountriesState(response.data));
  };

  getPopular = () => {
    Axios
      .get(window.API_URL + "popular")
      .then(response => this.setState({links: response.data}));
  };

  updateCountriesState(data) {
    this.setState({
      countries: data.items,
      totalRedirects: data.total_redirects,
      uniqueRedirects: data.unique_redirects
    });
  }

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

          <GeneralStatistics totalRedirects={this.state.totalRedirects}
                             uniqueRedirects={this.state.uniqueRedirects}
          />

          <div className="mt-4">
            <h2>Most popular links</h2>
            <Popular links={this.state.links}/>
          </div>
          <div className="mt-4">
            <h2>By Countries</h2>
            <Countries countries={this.state.countries}
                       totalRedirects={this.state.totalRedirects}
                       uniqueRedirects={this.state.uniqueRedirects}
            />
          </div>
        </Container>
      </div>
    );
  }
}

export default Statistics;
