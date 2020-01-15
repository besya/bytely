import React from "react";
import Table from "react-bootstrap/Table";
import Country from "./Country";

class Countries extends React.Component {
  countries = () => {
    const total = this.props.uniqueRedirects;

    return this.props.countries.map(country => {
      const percentage = 100.0 * parseInt(country.unique_redirects_count) / parseInt(total);
      country.percentage = Math.round(percentage);
      return country;
    });
  };

  render() {
    return(
      <div>
        <Table striped bordered hover className="mt-4">
          <thead>
          <tr>
            <th>Country</th>
            <th>Total uses</th>
            <th>Unique uses</th>
            <th>Percent of all users</th>
          </tr>
          </thead>
          <tbody>
          {this.countries().map((country, index) => (
            <Country key={index}
                     name={country.name}
                     redirects={country.redirects_count}
                     unique_redirects={country.unique_redirects_count}
                     percentage={country.percentage}
            />
          ))}
          </tbody>
        </Table>
      </div>
    );
  }
}

export default Countries;
