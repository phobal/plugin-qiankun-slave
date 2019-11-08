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

`name`  (string 可选) 子项目名称, 例如: 'ecosphere-admin'， 如果不传默认会去读系统 `package.json` 下的 `name` 字段

`isShowButton`  (boolean 可选) 是否显示回到主项目的按钮

`portalDomain` (string 可选) 主系统网址, 例如: 'http://admin.chinawyny.com'

## LICENSE

MIT
