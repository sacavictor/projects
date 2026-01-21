import React from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import Persons from "./components/Persons";
import Devices from "./components/Devices";
import EnergyMonitoring from "./components/EnergyMonitoring";
import ChatAndNotifications from "./components/ChatAndNotifications"; // Import the new component

function App() {
  return (
    <Router>
      <div style={{ padding: "20px" }}>
        <nav style={{ marginBottom: "20px", borderBottom: "1px solid #ccc", paddingBottom: "10px" }}>
          <Link to="/" style={{ marginRight: "15px" }}>Home (CRUDs)</Link>
        </nav>

        <Routes>
          {/* Home Route: Shows both Persons and Devices lists */}
          <Route path="/" element={
            <>
              <h1>System Administration</h1>
              <Persons />
              <hr style={{ margin: "30px 0" }} />
              <Devices />
              <hr style={{ margin: "30px 0" }} />
            </>
          } />

          {/* Monitoring Route: Shows the chart for a specific device */}
          <Route path="/monitoring/:deviceId" element={<EnergyMonitoring />} />
        </Routes>
        <ChatAndNotifications />
      </div>
    </Router>
  );
}

export default App;