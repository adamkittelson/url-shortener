import "../css/app.css"
import "phoenix_html"
import React from "react";
import ReactDOM from "react-dom";

function MyButton() {
  return (
    <button>Click me</button>
  );
}

export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}


const app = document.getElementById("app");
ReactDOM.render(<MyApp />, app);