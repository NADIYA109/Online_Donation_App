importScripts("https://www.gstatic.com/firebasejs/9.22.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.22.2/firebase-messaging-compat.js");

// Firebase config
const firebaseConfig = {
  apiKey: "AIzaSyBob6-kntfIHYnhuRms10pSUaQeiyex8Qs",
  authDomain: "online-donation-app.firebaseapp.com",
  projectId: "online-donation-app",
  storageBucket: "online-donation-app.appspot.com",   
  messagingSenderId: "1077383394491",
  appId: "1:1077383394491:web:93750cd3c6516d8bf6259e"
};

//Initialize Firebase
firebase.initializeApp(firebaseConfig);

//Initialize Firebase Messaging
const messaging = firebase.messaging();
