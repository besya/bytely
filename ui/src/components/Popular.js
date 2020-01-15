import React from "react";
import Table from "react-bootstrap/Table";
import PopularItem from "./PopularItem";

class Popular extends React.Component {

  render() {
    return(
      <Table striped bordered hover>
        <thead>
        <tr>
          <th>Destination URL</th>
          <th>Short URL</th>
          <th>Total uses</th>
          <th>Unique uses</th>
        </tr>
        </thead>
        <tbody>
        {this.props.links.map((link, index) => (
          <PopularItem key={index}
                       originalUrl={link.url}
                       shortUrl={link.short}
                       redirects={link.redirects_count}
                       unique_redirects={link.unique_redirects_count}
          />
        ))}
        </tbody>
      </Table>
    );
  }
}

export default Popular;
