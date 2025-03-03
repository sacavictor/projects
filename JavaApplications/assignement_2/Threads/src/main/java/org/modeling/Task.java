package org.modeling;

public class Task {
    private int ID;
    private int arrivaTime;
    private int waitingTime;
    private int serviceTime;

    public Task(int ID, int arrivaTime, int waitingTime, int serviceTime) {
        this.ID = ID;
        this.arrivaTime = arrivaTime;
        this.waitingTime = waitingTime;
        this.serviceTime = serviceTime;
    }

    public int getWaitingTime() {
        return waitingTime;
    }

    public void setWaitingTime(int waitTime) {
        this.waitingTime = waitTime;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public int getArrivaTime() {
        return arrivaTime;
    }

    public void setArrivaTime(int arrivaTime) {
        this.arrivaTime = arrivaTime;
    }

    public int getServiceTime() {
        return serviceTime;
    }
    public int getAndDecrementServiceTime(){int t = serviceTime; serviceTime--; return t;};

    public void setServiceTime(int serviceTime) {
        this.serviceTime = serviceTime;
    }

    @Override
    public String toString() {
        if(serviceTime > 0) {
            return "(" +
                    "ID=" + ID +
                    ", " + arrivaTime +
                    ", " + waitingTime +
                    ", " + serviceTime +
                    ')';
        }else return "Closed";
    }
}
