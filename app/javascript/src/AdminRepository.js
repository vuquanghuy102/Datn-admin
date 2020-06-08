import axios from 'axios';

const baseURL = '/api/admin';

const tokenElement = document.querySelector('meta[name=csrf-token]')
export default axios.create({
  baseURL,
  headers: {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': (tokenElement) ? tokenElement.content : null,
  },
});
