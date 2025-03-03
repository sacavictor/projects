package org.model;


/*
* The corresponding client table from database*/
public class Client {
    private int client_id;
    private String name;
    private String email;

    public Client(int client_id, String name, String email) {
        this.client_id = client_id;
        this.name = name;
        this.email = email;
    }
    public Client(){

    }

    public int getClient_id() {
        return client_id;
    }

    public void setClient_id(int clientId) {
        this.client_id = clientId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return
                "client_id=" + client_id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'';
    }
}
