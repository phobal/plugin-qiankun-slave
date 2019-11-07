# plugin-qiankun-slave

[![NPM version](https://img.shields.io/npm/v/plugin-qiankun-slave.svg?style=flat)](https://npmjs.org/package/plugin-qiankun-slave)
[![NPM downloads](http://img.shields.io/npm/dm/plugin-qiankun-slave.svg?style=flat)](https://npmjs.org/package/plugin-qiankun-slave)



## Install

```bash
# or yarn
$ npm install plugin-qiankun-slave
```

## Usage

Configure in `.umirc.js`,

```js
export default {
  plugins: [
    ['plugin-qiankun-slave', options],
  ],
}
```

## Options

`name`  (string) 子项目名称, 例如: 'ecosphere-admin'  

`portalDomain` (string) 主系统网址, 例如: 'http://admin.chinawyny.com'

## LICENSE

MIT
