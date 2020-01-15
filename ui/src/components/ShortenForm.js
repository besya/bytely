import React from "react";
import {Button, Col, Form} from "react-bootstrap";
import InputGroup from "react-bootstrap/InputGroup";
import {CopyToClipboard} from "react-copy-to-clipboard/lib/Component";

class ShortenForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {url: '', error: '', showCopy: false};
  }

  handleSubmit = event => {
    event.preventDefault();
    this.props
      .shortenUrl(this.state.url)
      .then(this.setForCopy)
      .catch(this.handleErrors);
  };

  setForCopy = link => {
    this.setState({url: link.short, showCopy: true});
  };

  handleChange = event => {
    event.preventDefault();
    this.setState({url: event.target.value, error: '', showCopy: false});
  };

  handleCopy = event => {
    let elm = event.target;
    elm.innerText = 'Copied!';
    setTimeout(() => (elm.innerText = 'Copy'), 1000);
  };

  handleErrors = reason => {
    this.setState({error: reason.message});
  };

  static getDerivedStateFromProps(props, state) {
    if (props.lastShort !== state.lastShort) {
      return {
        url: state.url,
        lastShort: props.lastShort
      };
    }
    return null;
  }

  render() {
    return(
      <Form onSubmit={this.handleSubmit}>
        <Form.Row>
          <Form.Group as={Col} md="10">
            <InputGroup>
              <Form.Control
                type="text"
                placeholder="Short your link"
                aria-describedby="inputGroupPrepend"
                name="url"
                value={this.state.url}
                onChange={this.handleChange}
                isInvalid={!!this.state.error}
              />
              <Form.Control.Feedback type="invalid">
                {this.state.error}
              </Form.Control.Feedback>
            </InputGroup>
          </Form.Group>
          <Col md={2} align="right">
            {this.state.showCopy ? (
              <CopyToClipboard text={this.state.url}>
                <Button onClick={this.handleCopy} className="btn-block">Copy</Button>
              </CopyToClipboard>
            ) : (
              <Button type="submit" className="btn-block">Shorten</Button>
            )}
          </Col>
        </Form.Row>
      </Form>
    );
  }
}

export default ShortenForm;
