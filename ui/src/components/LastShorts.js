import React from "react";
import Table from "react-bootstrap/Table";
import Button from "react-bootstrap/Button";
import {CopyToClipboard} from "react-copy-to-clipboard/lib/Component";

class LastShorts extends React.Component {
  handleCopy = event => {
    let elm = event.target;
    elm.innerText = 'Copied!';
    setTimeout(() => (elm.innerText = 'Copy'), 1000);
  };

  render() {
    return(
      <Table variant="dark">
        <tbody>
        {this.props.links.map((link, index) => (
          <tr key={index}>
            <td className="align-middle">
              <a href={link.url} target="_blank" className="text-white" rel="noopener noreferrer">
                {link.url}
              </a>
            </td>
            <td align="right" className="align-middle">
              <a href={link.short} target="_blank" className="text-white" rel="noopener noreferrer">
                {link.short}
              </a>
            </td>
            <td align="right">
              <CopyToClipboard text={link.short}>
                <Button onClick={this.handleCopy} className="btn-block">Copy</Button>
              </CopyToClipboard>
            </td>
          </tr>
        ))}
        </tbody>
      </Table>
    )
  }
}

export default LastShorts;
