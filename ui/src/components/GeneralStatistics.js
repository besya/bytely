import React from "react";
import CardDeck from "react-bootstrap/CardDeck";
import Card from "react-bootstrap/Card";
import Badge from "react-bootstrap/Badge";

class GeneralStatistics extends React.Component {
  render() {
    return(
      <CardDeck>
        <Card>
          <Card.Body>
            <Card.Text className="display-1 text-center">
              <Badge pill variant="success">{this.props.totalRedirects}</Badge>
            </Card.Text>
            <Card.Title className="text-center">Redirects</Card.Title>
          </Card.Body>
        </Card>
        <Card>
          <Card.Body>
            <Card.Text className="display-1 text-center">
              <Badge pill variant="info">{this.props.uniqueRedirects}</Badge>
            </Card.Text>
            <Card.Title className="text-center">Users</Card.Title>
          </Card.Body>
        </Card>
      </CardDeck>
    );
  }
}

export default GeneralStatistics;
