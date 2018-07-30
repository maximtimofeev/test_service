import createChannel from 'client/cable';

let callback;

const notify = createChannel('NotificationChannel', {
  received({ message }) {
    if (callback) callback.call(null, message);
  }
});

function sendMessage(message) {
  notify.perform('send_message', { message });
}

function setCallback(fn) {
  callback = fn;
}

export { sendMessage, setCallback };
