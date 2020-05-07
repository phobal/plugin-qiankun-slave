// ref:
// - https://umijs.org/plugin/develop.html
import { IApi } from 'umi'
// @ts-ignore
import { readFileSync } from 'fs'
import { join } from 'path'

export default function(api: IApi) {
  const { paths, cwd, utils: { Mustache }, } = api
  const { name: pkgName } = require(join(cwd, 'package.json'))

  api.describe({
    key: 'qiankun-slave',
    config: {
      default: {
        portalDomain: null,
        isShowButton: true,
        name: pkgName,
      },
      schema(joi) {
        return joi.object({
          portalDomain: joi.string(),
          isShowButton: joi.boolean(),
          name: joi.string(),
        });
      },
    },
  });
  // 更改打包默认配置
  api.modifyDefaultConfig((memo) => {
    const name = pkgName
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
  api.onGenerateFiles(() => {
    const { portalDomain, isShowButton } = api.config['qiankun-slave']
    const homeButtonTpl = readFileSync(
      join(__dirname, 'templates', 'HomeButtonWrapper.jsx.tpl'),
      'utf-8',
    );
    api.writeTmpFile({
      path: 'plugin-qiankun-slave/HomeButtonWrapper.jsx',
      content: Mustache.render(homeButtonTpl, {
        portalDomain,
        isShowButton
      }),
    });
    // runtime.tsx
    const runtimeTpl = readFileSync(
      join(__dirname, 'templates', 'runtime.tpl'),
      'utf-8',
    );
    api.writeTmpFile({
      path: 'plugin-qiankun-slave/runtime.jsx',
      content: runtimeTpl,
    });
  })
  api.addRuntimePlugin(() => join(paths.absTmpPath, 'plugin-qiankun-slave/runtime'))
}
