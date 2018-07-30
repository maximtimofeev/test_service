import { sendMessage, setCallback } from 'client/notify';
import './header.scss';

const notice = document.getElementById('message');
const detail = document.getElementById('detail-message');

const notice_text = '<span class="message">!</span>'

setCallback(message => {
  notice.insertAdjacentHTML('afterbegin', notice_text)
  detail.insertAdjacentHTML('afterbegin', message);
});
