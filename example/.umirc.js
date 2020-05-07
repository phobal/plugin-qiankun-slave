import { join } from 'path'

export default {
  routes: [{ path: '/', component: './index' }],
  plugins: [
      join(__dirname, '..', require('../package.json').src || 'index.js'),
  ],
  'qiankun-slave': { portalDomain: 'http://172.16.11.30:5000' }
}
