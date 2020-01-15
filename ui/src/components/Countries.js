import React from "react";
import Table from "react-bootstrap/Table";
import Country from "./Country";

class Countries extends React.Component {
  render() {
    return(
      <div>
        <Table striped bordered hover>
          <thead>
          <tr>
            <th>Country</th>
            <th>Total uses</th>
            <th>Unique uses</th>
          </tr>
          </thead>
          <tbody>
          {this.props.countries.map((country, index) => (
            <Country key={index}
                     name={country.name}
                     redirects={country.redirects_count}
                     unique_redirects={country.unique_redirects_count}
            />
          ))}
          </tbody>
        </Table>
      </div>
    );
  }
}

export default Countries;
