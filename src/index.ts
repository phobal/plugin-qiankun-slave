// ref:
// - https://umijs.org/plugin/develop.html
import { IApi } from 'umi-plugin-types'
// @ts-ignore
import Mustache from 'mustache'
import { readFileSync, writeFileSync } from 'fs'
import { join } from 'path'
interface Options {
  name?: string
  isShowButton?: boolean
  portalDomain?: string
}

export default function(api: IApi, options: Options) {
  const { paths, cwd } = api
  const { name: pkgName } = require(join(cwd, 'package.json'))
  const { portalDomain, isShowButton = true, name: optionName } = options || {}
  const name = optionName || pkgName
  // 更改打包默认配置
  api.modifyDefaultConfig((memo) => {
    return {
      ...memo,
      base: `/${name}`,
      outputPath: `./dist/${name}`,
      publicPath: `/${name}/`,
      mountElementId: `${name}`,
      define: {
        // @ts-ignore
        ...memo.define,
        API_PREFIX: `/api-${name}`
      },
    }
  })
  // 回到主项目按钮
  if (isShowButton) {
    // @ts-ignore
    api.addRendererWrapperWithComponent(() => {
      const wrapperTpl = readFileSync(join(__dirname, './templates/HomeButtonWrapper.jsx.tpl'), 'utf-8');
      const wrapperContent = Mustache.render(wrapperTpl, {
        portalDomain,
      })
      const wrapperPath = join(paths.absTmpDirPath, './HomeButtonWrapper.jsx')
      writeFileSync(wrapperPath, wrapperContent, 'utf-8')
      return wrapperPath;
    })
  }
}
