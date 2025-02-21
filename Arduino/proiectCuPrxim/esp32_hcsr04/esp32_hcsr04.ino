
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

// WiFi credentials
#define WIFI_SSID "UTCN-Guest"
#define WIFI_PASSWORD "utcluj.ro"

// Firebase credentials
const char dburl[] = "https://esp32-5230c-default-rtdb.europe-west1.firebasedatabase.app";
const char dbapi[] = "AIzaSyBgQDsfEHfkRQ8VFwpNDerczQwLOzavIrY";

// Firebase objects
FirebaseData firebaseData;
FirebaseConfig firebaseConfig;
FirebaseAuth auth;
// Fingerprint sensor setup
#define RX_PIN 17
#define TX_PIN 16

const int trigPin = 5;
const int echoPin = 18;
#define SOUND_SPEED 0.034
#define CM_TO_INCH 0.393701

long duration;
float distanceCm;
float distanceInch;

bool signedUp = false;

#define GREENLED1 19
#define GREENLED2 29
#define REDLED 30

#define FIRSTLIMIT 100
#define SECONDLIMIT 50
#define LASTIMIT 10

void setup() {
  Serial.begin(115200);
   Serial.printf("Starting ESP32...");
  // WiFi connection
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to Wi-Fi...");
  }
  Serial.println("Connected with ip");
  Serial.println(WiFi.localIP());

  // Firebase configuration
  firebaseConfig.database_url = dburl;
  firebaseConfig.api_key = dbapi;
  if(Firebase.signUp(&firebaseConfig, &auth, "", "")){
    Serial.println("Signed in");
    signedUp = true;
  }else Serial.printf("Sign up error");

  firebaseConfig.token_status_callback = tokenStatusCallback;
  Firebase.begin(&firebaseConfig, &auth);
  Firebase.reconnectWiFi(true);


  // proximity sensor setup
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT);

  pinMode(GREENLED1, OUTPUT);
  pinMode(GREENLED2, OUTPUT);
  pinMode(REDLED, OUTPUT);
}

void loop() {
  // Example: Enroll a fingerprint or verify

  if(Firebase.ready() && signedUp){
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
  
  // Reads the echoPin, returns the sound wave travel time in microseconds
    duration = pulseIn(echoPin, HIGH);
  
  // Calculate the distance
    distanceCm = duration * SOUND_SPEED/2;
  
  // Convert to inches
    distanceInch = distanceCm * CM_TO_INCH;
  
  // Prints the distance in the Serial Monitor
    Serial.print("Distance (cm): ");
    Serial.println(distanceCm);
    Serial.print("Distance (inch): ");
    Serial.println(distanceInch);

    if(distanceCm < FIRSTLIMIT)
      digitalWrite(GREENLED1, HIGH);


    if(distanceCm < SECONDLIMIT)
      digitalWrite(GREENLED2, HIGH);
    

    if (distanceCm < LASTIMIT)
      digitalWrite(REDLED, HIGH);
    

    String path = "/sensors/proximity";  // Replace with your desired database path
    if (Firebase.RTDB.setFloat(&firebaseData, path + "/distanceCm", distanceCm)) {
      Serial.println("Distance in cm sent to Firebase.");
    } else {
      Serial.print("Failed to send distance in cm. Reason: ");
      Serial.println(firebaseData.errorReason());
    }

    if (Firebase.RTDB.setFloat(&firebaseData, path + "/distanceInch", distanceInch)) {
      Serial.println("Distance in inch sent to Firebase.");
    } else {
      Serial.print("Failed to send distance in inch. Reason: ");
      Serial.println(firebaseData.errorReason());
    }
  }
  delay(2000);
}
