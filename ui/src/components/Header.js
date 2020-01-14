import Navbar from "react-bootstrap/Navbar";
import Nav from "react-bootstrap/Nav";
import React from "react";
import Link from "react-router-dom/Link";

export default function () {
  return(
    <Navbar bg="dark" variant="dark">
      <Navbar.Brand href="/">Navbar</Navbar.Brand>
      <Nav className="mr-auto">
        <Link to="/" className="nav-link">Home</Link>
        <Link to="/statistics"  className="nav-link">Statistics</Link>
      </Nav>
    </Navbar>
  );
}
