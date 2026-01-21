import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { Bar } from 'react-chartjs-2';
import axios from 'axios';
import { 
  Chart as ChartJS, 
  CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend 
} from 'chart.js';

// Register ChartJS components
ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);
const EnergyMonitoring = () => { // No need for { deviceId } prop here
    const { deviceId } = useParams(); // Get it from the URL instead
    const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split('T')[0]);
    const [chartData, setChartData] = useState(null);

    const authHeader = {
        Authorization: "Basic " + btoa("victor:root")
    };

    useEffect(() => {
        // Use fetch to avoid the "axios not found" error
        fetch(`/monitoring/history?deviceId=${deviceId}&date=${selectedDate}`, {
            headers: authHeader
        })
        .then(res => {
            if (!res.ok) throw new Error("Status: " + res.status);
            return res.json();
        })
        .then(data => {
            const hourlyValues = new Array(24).fill(0);
            
            data.forEach(item => {
                // Ensure the timestamp from the DB is converted to the local hour (0-23)
                const hour = new Date(item.timestamp).getHours();
                hourlyValues[hour] = item.totalConsumption;
            });

            setChartData({
                labels: Array.from({ length: 24 }, (_, i) => `${i}:00`),
                datasets: [{
                    label: 'kWh Consumed',
                    data: hourlyValues,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                }]
            });
        })
        .catch(error => console.error("Error fetching data:", error));
    }, [deviceId, selectedDate]);

    return (
        <div style={{ padding: "20px" }}>
            <h3>Device History: {deviceId}</h3>
            <input 
                type="date" 
                value={selectedDate} 
                onChange={(e) => setSelectedDate(e.target.value)} 
            />
            <div style={{ height: '400px', marginTop: '20px' }}>
                {chartData ? <Bar data={chartData} /> : <p>Loading Chart...</p>}
            </div>
        </div>
    );
};
export default EnergyMonitoring;