import React, { useState, useEffect, useRef } from 'react';
import SockJS from 'sockjs-client';
import { Stomp } from '@stomp/stompjs';

const ChatAndNotifications = () => {
    const [messages, setMessages] = useState([]);
    const [input, setInput] = useState("");
    const [connected, setConnected] = useState(false);
    const stompClient = useRef(null);

    useEffect(() => {
        // 1. Connect to the WebSocket Microservice
        const socket = new SockJS('/ws'); // Adjust port to your WebSocket service
        stompClient.current = Stomp.over(socket);

        stompClient.current.connect({}, (frame) => {
            setConnected(true);
            console.log('Connected: ' + frame);

            // 2. Subscribe to Overconsumption Notifications (Broadcasting)
            stompClient.current.subscribe('/topic/alerts', (notification) => {
                alert("🚨 SYSTEM ALERT: " + notification.body);
            });

            // 3. Subscribe to Chat Responses
            stompClient.current.subscribe('/topic/chat', (message) => {
                const reply = JSON.parse(message.body);
                setMessages(prev => [...prev, { sender: reply.senderId, content: reply.content }]);
            });
        }, (error) => {
            console.error("STOMP error", error);
        });

        return () => {
            if (stompClient.current) stompClient.current.disconnect();
        };
    }, []);

    const sendMessage = async () => {
        if (!input.trim()) return;

        const userMsg = { senderId: "User1", content: input };

        // Add user message to UI immediately
        setMessages(prev => [...prev, { sender: "You", content: input }]);

        // 4. Send to Customer Support Microservice (REST API)
        try {
            await fetch('/chat/send', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(userMsg)
            });
            setInput("");
        } catch (err) {
            console.error("Failed to send message", err);
        }
    };

    return (
        <div style={styles.chatContainer}>
            <h3>Customer Support & Alerts {connected ? "🟢" : "🔴"}</h3>
            <div style={styles.messageBox}>
                {messages.map((m, i) => (
                    <div key={i} style={m.sender === "You" ? styles.userMsg : styles.supportMsg}>
                        <strong>{m.sender}:</strong> {m.content}
                    </div>
                ))}
            </div>
            <div style={styles.inputArea}>
                <input
                    value={input}
                    onChange={(e) => setInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
                    placeholder="Type a message..."
                    style={styles.input}
                />
                <button onClick={sendMessage} style={styles.button}>Send</button>
            </div>
        </div>
    );
};

const styles = {
    chatContainer: { border: '1px solid #ccc', padding: '10px', width: '350px', position: 'fixed', bottom: '20px', right: '20px', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 4px 8px rgba(0,0,0,0.1)' },
    messageBox: { height: '300px', overflowY: 'scroll', marginBottom: '10px', display: 'flex', flexDirection: 'column' },
    userMsg: { alignSelf: 'flex-end', backgroundColor: '#e1ffc7', padding: '5px', borderRadius: '5px', margin: '2px' },
    supportMsg: { alignSelf: 'flex-start', backgroundColor: '#f0f0f0', padding: '5px', borderRadius: '5px', margin: '2px' },
    inputArea: { display: 'flex' },
    input: { flexGrow: 1, padding: '5px' },
    button: { marginLeft: '5px', cursor: 'pointer' }
};

export default ChatAndNotifications;