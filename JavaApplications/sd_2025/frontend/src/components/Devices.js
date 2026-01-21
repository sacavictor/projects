import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom"; // <--- 1. Import this

const DEVICES_API = "/devices";

function Devices() {
  const navigate = useNavigate(); // <--- 2. Initialize navigate
  const [devices, setDevices] = useState([]);
  const [formData, setFormData] = useState({
    model: "",
    manufacturer: "",
    personId: "",
    personName: ""
  });
  
  const [selectedPersonId, setSelectedPersonId] = useState("");
  const [selectedPersonName, setSelectedPersonName] = useState("");
  const [persons, setPersons] = useState([]);

  const authHeader = {
    Authorization: "Basic " + btoa("victor:root")
  };

  useEffect(() => {
    fetch(DEVICES_API, { headers: authHeader })
      .then(res => {
        if (!res.ok) {
          throw new Error("Unauthorized or API Error: " + res.status);
        }
        return res.json();
      })
      .then(data => setDevices(data))
      .catch(err => console.error(err));
  }, []);

  useEffect(() => {
    fetch("/people", { headers: authHeader })
      .then(res => {
        if (!res.ok) throw new Error("Failed to fetch persons: " + res.status);
        return res.json();
      })
      .then(data => setPersons(data))
      .catch(err => console.error(err));
  }, []);


  
  const addDevice = () => {
    const payload = {
      model: formData.model,
      manufacturer: formData.manufacturer,
      personId: formData.personId,
      personName: formData.personName,
      maxHourlyEnergyConsumption: formData.maxHourlyEnergyConsumption
    };

    if (selectedPersonId) {
      payload.personId = selectedPersonId;
      payload.personName = selectedPersonName;
    }

    fetch(DEVICES_API, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        ...authHeader
      },
      body: JSON.stringify(payload)
    })
      .then(res => {
        if (!res.ok) throw new Error("Failed to add device");
        return res.text();
      })
      .then(() => fetch(DEVICES_API, { headers: authHeader }))
      .then(res => res.json())
      .then(data => {
        setDevices(data);
        setFormData({ model: "", manufacturer: "", personName: "", maxHourlyEnergyConsumption: "" });
        setSelectedPersonId("");
        setSelectedPersonName("");
      })
      .catch(err => console.error(err));
  };

  const deleteDevice = (id) => {
    fetch(`${DEVICES_API}/${id}`, {  // ✅ FIXED: Added parentheses
      method: "DELETE",
      headers: authHeader
    })
      .then(res => {
        if (!res.ok) throw new Error("Failed to delete device");
        setDevices(devices.filter(d => d.id !== id));
      })
      .catch(err => console.error(err));
  };

  

  const updateField = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };


  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h2>Devices</h2>
      <label>Model: </label>
      <input
        name="model"
        value={formData.model}
        onChange={updateField}
      />
      <br />
      <label>Manufacturer: </label>
      <input
        name="manufacturer"
        value={formData.manufacturer}
        onChange={updateField}
      />
      <br />
      <label>Max Hourly Energy Consumption: </label>
      <input
        name="maxHourlyEnergyConsumption"
        value={formData.maxHourlyEnergyConsumption}
        onChange={updateField}
      />
      <br />
      <label>Owner (Person): </label>
      <select
        value={selectedPersonId}
        onChange={(e) => {
          const selected = persons.find(p => p.id === e.target.value);
          setSelectedPersonId(selected?.id || "");
          setSelectedPersonName(selected?.name || "");
        }}
      >
        <option value="">--Select Person--</option>
        {persons.map(p => (
          <option key={p.id} value={p.id}>{p.name}</option>
        ))}
      </select>


      <br />
      <button onClick={addDevice}>Add Device</button>
      <ul>
        {devices.map(d => (
          <li key={d.id}>
            {d.model} — {d.manufacturer} — Owner: {d.personName || "N/A"}
            <button onClick={() => deleteDevice(d.id)} style={{ marginLeft: "10px" }}>
              Delete
            </button>
          </li>
        ))}
      </ul>
      <ul>
        {devices.map(d => (
          <li key={d.id} style={{ marginBottom: "10px" }}>
            {d.model} — {d.manufacturer} — Owner: {d.personName || "N/A"}
            
            {/* Delete Button */}
            <button onClick={() => deleteDevice(d.id)} style={{ marginLeft: "10px", color: "red" }}>
              Delete
            </button>

            {/* NEW: Monitoring Button */}
            <button 
                onClick={() => navigate(`/monitoring/${d.id}`)} 
                style={{ marginLeft: "10px", backgroundColor: "#4CAF50", color: "white" }}
            >
              View Energy
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Devices;