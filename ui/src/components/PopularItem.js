import React from "react";

class PopularItem extends React.Component {
  render() {
    return(
      <tr>
        <td>
          <a href={this.props.originalUrl} target="_blank" rel="noopener noreferrer">
            {this.props.originalUrl}
          </a>
        </td>
        <td>
          <a href={this.props.shortUrl} target="_blank" rel="noopener noreferrer">
            {this.props.shortUrl}
          </a>
        </td>
        <td>{this.props.redirects}</td>
        <td>{this.props.unique_redirects}</td>
      </tr>
    );
  }
}

export default PopularItem;
