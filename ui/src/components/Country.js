import React from "react";

class Country extends React.Component {
  render() {
    return(
      <tr>
        <td>{this.props.name}</td>
        <td>{this.props.redirects}</td>
        <td>{this.props.unique_redirects}</td>
      </tr>
    );
  }
}

export default Country;
