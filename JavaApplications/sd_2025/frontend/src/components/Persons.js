import React, { useState, useEffect } from "react";

const PERSONS_API = "/people";

function Persons() {
  const [persons, setPersons] = useState([]);
  const [formData, setFormData] = useState({
    name: "",
    age: "",
    address: ""
  });

  const authHeader = {
    Authorization: "Basic " + btoa("victor:root")
  };

useEffect(() => {
  fetch(PERSONS_API, {
    headers: { Authorization: "Basic " + btoa("victor:root") }
  })
    .then(res => {
      if (!res.ok) {
        throw new Error("Unauthorized or API error: " + res.status);
      }
      return res.json();
    })
    .then(data => setPersons(data))
    .catch(err => console.error(err));
}, []);

  const addUser = () => {
    fetch(PERSONS_API, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        ...authHeader
      },
      body: JSON.stringify({
        name: formData.name,
        age: Number(formData.age),
        address: formData.address
      })
    })
      .then(res => res.json())
      .then(id => {
        setPersons([...persons, 
          {id,
            name: formData.name,
            age: Number(formData.age),
            address: formData.address
          }
        ]);
        setFormData({ name: "", age: "", address: "" }); // Clear inputs ✅
      });
  };

    const deleteUser = (id) => {
    fetch(`${PERSONS_API}/${id}`, {
      method: "DELETE",
      headers: authHeader
    })
      .then(res => {
        if (!res.ok) throw new Error("Failed to delete user");
        setPersons(persons.filter(u => u.id !== id));
      })
      .catch(err => console.error(err));
  };

  const updateField = e => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h2>Persons</h2>

      <label>Name: </label>
      <input
        name="name"
        value={formData.name}
        onChange={updateField}
      />

      <br />

      <label>Age: </label>
      <input
        name="age"
        type="number"
        value={formData.age}
        onChange={updateField}
      />

      <br />

      <label>Address: </label>
      <input
        name="address"
        value={formData.address}
        onChange={updateField}
      />

      <br />
      <button onClick={addUser}>Add User</button>

      <ul>
        {persons.map(u => (
          <li key={u.id}>
            {u.name} — {u.age} — {u.address}
            <button onClick={() => deleteUser(u.id)} style={{ marginLeft: "10px" }}>
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Persons;
