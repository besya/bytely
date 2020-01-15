import Navbar from "react-bootstrap/Navbar";
import Nav from "react-bootstrap/Nav";
import React from "react";
import {NavLink} from "react-router-dom";

export default function () {
  return(
    <Navbar bg="dark" variant="dark">
      <Navbar.Brand href="/">Navbar</Navbar.Brand>
      <Nav className="mr-auto">
        <NavLink to="/" exact className="nav-link" activeClassName="active">Home</NavLink>
        <NavLink to="/statistics" className="nav-link" activeClassName="active">Statistics</NavLink>
      </Nav>
    </Navbar>
  );
}
