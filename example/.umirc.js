import { join } from 'path'

export default {
  routes: [{ path: '/', component: './index' }],
  plugins: [
    [
      'umi-plugin-react',
      {
        title: '测试',
        antd: true,
        dva: { hmr: true, immer: true },
        dynamicImport: {
          webpackChunkName: true,
          level: 3
        },
        chunks: ['umi'],
        dll: true
      }
    ],
    [
      join(__dirname, '..', require('../package').main || 'index.js'),
      { name: 'test', portalDomain: 'http://172.16.11.30:5000' }
    ]
  ]
}
